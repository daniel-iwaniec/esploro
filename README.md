# esploro

Simple R&D project

## Web Shield
### How to run

After cloning repository run `ops/up.sh`

`Minikube` and `kubectl` should suffice to run this project on Debian/Ubuntu

After that add `10.10.10.10 webshield.lan` in your `/etc/hosts` or equivalent file for ingress to work

After that visit http://webshield.lan/

To review code look at `app/serviced`

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

First thing I would improve is general architecture:
* I would divide application into bounded contexts
* I would utilize CQRS, Ports&Adapters, some concepts from DDD
* I would divide it into layers for Presentation/Application/Domain/Infrastructure

Other than that:
* I would probably create some service for persisting transactions
* I would properly handle currency (float isn't great)
* I would more precisely handle invalid CSV files and present those errors/exceptions on frontend

I tried to show some more _advanced_ concepts using `TransactionReader`

You can also look at my other PHP repositories to see more architectural patterns, I just couldnt fit that into ~3hour task
