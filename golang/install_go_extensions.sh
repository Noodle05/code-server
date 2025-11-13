#!/bin/bash

echo "**** installing extensions ****"
EXT_LIST="eamodio.gitlens golang.go ms-azuretools.vscode-docker usernamehw.errorlens"
for EXT in $EXT_LIST;
    do /usr/local/bin/install-extension $EXT;
done
