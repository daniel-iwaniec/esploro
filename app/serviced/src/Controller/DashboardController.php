<?php

declare(strict_types=1);

namespace App\Controller;

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

#[Route('/dashboard', name: 'dashboard', methods: ['GET', 'POST'])]
class DashboardController extends AbstractController
{
    public function __invoke(Request $request): Response
    {
        $data = null;
        if ($request->isMethod('POST')) {
            $file = $request->files->get('csv')->getContent();

            $data = [];
            $rows = str_getcsv($file, "\n");
            foreach ($rows as $row) {
                $data[] = str_getcsv($row);
            }
        }

        return $this->render('dashboard.html.twig', [
            'data' => $data
        ]);
    }
}
