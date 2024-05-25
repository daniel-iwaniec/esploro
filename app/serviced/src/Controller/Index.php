<?php

declare(strict_types=1);

namespace App\Controller;

use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/', methods: ['GET'])]
class Index
{
    public function __invoke(): JsonResponse
    {
        return new JsonResponse(['test' => 1]);
    }
}
