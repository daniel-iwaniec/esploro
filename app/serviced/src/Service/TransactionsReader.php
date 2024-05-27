<?php

declare(strict_types=1);

namespace App\Service;

use Generator;
use SplFileInfo;
use App\Dto\TransactionDto;
use App\Exception\InvalidTransactions;

interface TransactionsReader
{
    /**
     * @return Generator<TransactionDto>
     * @throws InvalidTransactions
     */
    public function read(SplFileInfo $file): Generator;
}
