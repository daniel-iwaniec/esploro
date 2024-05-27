<?php

declare(strict_types=1);

namespace App\Service;

use Exception;
use Generator;
use SplFileInfo;
use DateTimeImmutable;
use App\Dto\TransactionDto;
use App\Exception\InvalidTransactions;

class CsvTransactionsReader implements TransactionsReader
{
    /**
     * @return Generator<TransactionDto>
     * @throws InvalidTransactions
     */
    public function read(SplFileInfo $file): Generator
    {
        $fileObject = $file->openFile();

        while (!$fileObject->eof()) {
            $line = str_getcsv($fileObject->fgets());

            if ($line === [null]) {
                continue;
            }

            if (count($line) !== 3) {
                throw InvalidTransactions::invalidCsv();
            }

            try {
                $transaction = new TransactionDto(
                    (float) $line[0],
                    new DateTimeImmutable($line[1]),
                    $line[2],
                );
            } catch (Exception $exception) {
                throw InvalidTransactions::invalidDto($exception);
            }

            yield $transaction;
        }
    }
}
