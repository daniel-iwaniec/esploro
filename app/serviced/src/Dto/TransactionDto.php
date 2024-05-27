<?php

declare(strict_types=1);

namespace App\Dto;

use DateTimeImmutable;

final readonly class TransactionDto
{
    public function __construct(
        public float $amount,
        public DateTimeImmutable $date,
        public string $description
    ) {
    }
}
