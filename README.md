# esploro

Simple R&D project

## Web Shield
### How to run

After cloning repository run `ops/up.sh`

Some dependencies are needed, `Minikube` and `kubectl` should suffice 

After that add `10.10.10.10 webshield.lan` in your `/etc/hosts` or equivalent file for ingress to work

After that visit http://webshield.lan/

### Description

I've created more or less standard symfony application with registration&login for users

After login users can upload CSV with transactions, example file:
```csv
100.00,05-09-2024,something
200.00,06-09-2024,lorem ipsum dolor sit amet
159.12,01-09-2024,some description
34.43,05-06-2024,some transaction
19.85,01-06-2024,something new
```

First thing I would improve is general architecture, I would divide application into bounded contexts, I would
utilize CQRS, Ports&Adapters, some concepts from DDD, layers for Presentation/Application/Domain/Infrastructure and so on.
Right now it is more or less standard symfony. Other than that, I would take grater care for amount handling (float isn't great),
more precisely handle invalid files and presenting those errors/exceptions on frontend.

I tried to show some more advanced concepts using `TransactionReader`
