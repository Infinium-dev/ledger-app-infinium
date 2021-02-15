# ledger-app-infinium

## Prerequisites

* Ubuntu Linux x86-64

## Environment preparing (done once)
```
sudo apt update
sudo apt install docker.io
```
## Building and deployment

* Attach a Ledger Nano S to a computer and enter your pin code.
* The following command builds and installs the Infinium app to the Ledger Nano S. Run it every time you want to rebuild and/or reinstall the Infinium app:
```
sudo ./install_infinium.sh
```
* Follow the instructions on the Ledger's screen to finish the installation procedure.
