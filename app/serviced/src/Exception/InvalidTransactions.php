<?php

declare(strict_types=1);

namespace App\Exception;

use Exception;

final class InvalidTransactions extends Exception
{
    public static function invalidCsv(): self
    {
        return new self('Invalid CSV');
    }

    public static function invalidDto(Exception $previousException): self
    {
        return new self('Invalid DTO', 0, $previousException);
    }
}
