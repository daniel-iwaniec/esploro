CREATE USER esploro WITH PASSWORD 'esploro';
CREATE DATABASE esploro with encoding 'UTF8';
GRANT ALL PRIVILEGES ON DATABASE esploro TO esploro;

\connect esploro root
CREATE SCHEMA servicea AUTHORIZATION esploro;
CREATE SCHEMA serviceb AUTHORIZATION esploro;
GRANT CREATE ON SCHEMA public TO esploro;
GRANT CREATE ON SCHEMA servicea TO esploro;
GRANT CREATE ON SCHEMA serviceb TO esploro;
