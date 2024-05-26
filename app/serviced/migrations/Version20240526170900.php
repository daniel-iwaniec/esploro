<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

final class Version20240526170900 extends AbstractMigration
{
    public function getDescription(): string
    {
        return 'Create transaction table';
    }

    public function up(Schema $schema): void
    {
        $this->addSql(<<<SQL
        CREATE TABLE transaction (
            id UUID NOT NULL,
            amount DOUBLE PRECISION NOT NULL,
            date TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
            description VARCHAR(255) NOT NULL,
            PRIMARY KEY(id)
        )
        SQL
        );
    }

    public function down(Schema $schema): void
    {
        $this->addSql(<<<SQL
        DROP TABLE transaction
        SQL
        );
    }
}
