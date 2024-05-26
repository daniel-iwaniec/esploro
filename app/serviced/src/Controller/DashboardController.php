<?php

declare(strict_types=1);

namespace App\Controller;

use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

#[Route('/dashboard', name: 'dashboard', methods: ['GET'])]
class DashboardController extends AbstractController
{
    public function __invoke(): Response
    {
        return $this->render('dashboard.html.twig');
    }
}
