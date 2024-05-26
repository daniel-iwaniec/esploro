<?php

declare(strict_types=1);

namespace App\Controller;

use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

#[Route('/', methods: ['GET'])]
class Index extends AbstractController
{
    public function __invoke(): Response
    {
        return $this->render('index.html.twig');
    }
}
