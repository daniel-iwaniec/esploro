<?php

declare(strict_types=1);

namespace App\Controller;

use Exception;
use App\Entity\Transaction;
use DateTimeImmutable;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

#[Route('/dashboard', name: 'dashboard', methods: ['GET', 'POST'])]
class DashboardController extends AbstractController
{
    public function __construct(
        private readonly EntityManagerInterface $entityManager
    ) {
    }

    /**
     * @throws Exception
     */
    public function __invoke(Request $request): Response
    {
        $data = [];
        $total = 0;
        if ($request->isMethod('POST')) {
            $file = $request->files->get('csv')->getContent();

            $data = [];
            $rows = str_getcsv($file, "\n");
            foreach ($rows as $row) {
                $data[] = str_getcsv($row);
            }

            foreach ($data as $item) {
                $transaction = new Transaction();
                $transaction->setAmount((float) $item[0]);
                $transaction->setDate(new DateTimeImmutable($item[1]));
                $transaction->setDescription((string) $item[2]);

                $total += $transaction->getAmount();

                $this->entityManager->persist($transaction);
                $this->entityManager->flush();
            }
        }

        return $this->render('dashboard.html.twig', [
            'data' => $data,
            'totalCount' => count($data),
            'total' => $total
        ]);
    }
}
