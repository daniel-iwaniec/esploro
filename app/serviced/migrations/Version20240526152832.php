<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

final class Version20240526152832 extends AbstractMigration
{
    public function getDescription(): string
    {
        return 'Add username';
    }

    public function up(Schema $schema): void
    {
        $this->addSql(<<<SQL
        ALTER TABLE "user"
        ADD username VARCHAR(255) NOT NULL DEFAULT ''
        SQL
        );

        $this->addSql(<<<SQL
        CREATE UNIQUE INDEX UNIQ_IDENTIFIER_USERNAME ON "user" (username)
        SQL
        );
    }

    public function down(Schema $schema): void
    {
        $this->addSql(<<<SQL
        DROP INDEX UNIQ_IDENTIFIER_USERNAME
        SQL
        );

        $this->addSql(<<<SQL
        ALTER TABLE "user" DROP username
        SQL
        );
    }
}
