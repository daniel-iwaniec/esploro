<?php

declare(strict_types=1);

namespace App\Controller;

use Exception;
use App\Entity\Transaction;
use App\Service\TransactionsReader;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

#[Route('/dashboard', name: 'dashboard', methods: ['GET', 'POST'])]
class DashboardController extends AbstractController
{
    private const int CSV_BATCH = 10;

    public function __construct(
        private readonly EntityManagerInterface $entityManager,
        private readonly TransactionsReader $transactionReader,
    ) {
    }

    /**
     * @throws Exception
     */
    public function __invoke(Request $request): Response
    {
        if ($request->isMethod('POST')) {
            $file = $request->files->get('csv');

            $total = $count = 0;
            foreach ($this->transactionReader->read($file) as $transactionDto) {
                $transaction = new Transaction();
                $transaction->setAmount($transactionDto->amount);
                $transaction->setDate($transactionDto->date);
                $transaction->setDescription($transactionDto->description);
                $this->entityManager->persist($transaction);

                $count++;
                $total += $transaction->getAmount();

                if (($count % self::CSV_BATCH) === 0) {
                    $this->entityManager->flush();
                    $this->entityManager->clear();
                }
            }

            $this->entityManager->flush();
            $this->entityManager->clear();
        }

        return $this->render('dashboard.html.twig', [
            'total' => $total ?? 0,
            'count' => $count ?? 0,
        ]);
    }
}
