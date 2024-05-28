# born2beroot
## Description
This project is an introduction to system administration. It is a guided project that will help you get your feet wet in the world of system administration. You will be working on a virtual machine, your first server. You will install a debian server on it, and you will have to configure it to be compliant with the rules of the subject.

## Generate a password hash for macOS
Generate a password hash with the following command:
``` bash
openssl passwd -6 'password'
./verify_password.sh 'password' '$6$...'
```
Remember to add quotes to the hashed password in the verify_password.sh script.

### Encryption Disk
Please change the passphrase of the encrypted disk with the following command in the preseed.cfg file:
``` bash
d-i partman-crypto/passphrase string mypassword
d-i partman-crypto/passphrase-again string mypassword
```

