# esploro

I intened this to be my side R&D project, and since I wanted to have PHP service here I just did the assignment here.

## Web Shield
### Other examples
I highly implore You to also take a look at https://github.com/daniel-iwaniec/gog (or my other repositories) to get a better sense about architectural patterns, I just couldn't fit those into time limit.

### CSV assignment

To review code look at `app/serviced`

To run, after cloning repository execute `ops/up.sh`

`Minikube` and `kubectl` should suffice to run this project on Debian/Ubuntu

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

First thing I would improve is general architecture:
* I would divide application into bounded contexts
* I would utilize CQRS, Ports&Adapters, some concepts from DDD
* I would divide it into layers for Presentation/Application/Domain/Infrastructure

Other than that:
* I would probably create some service for persisting transactions
* I would properly handle currency (float isn't great)
* I would more precisely handle invalid CSV files and present those errors/exceptions on frontend

I tried to show some more _advanced_ concepts using `TransactionReader`
