#!/bin/bash

echo "**** installing extensions ****"
EXT_LIST="eamodio.gitlens vscjava.vscode-java-pack vmware.vscode-spring-boot vmware.vscode-boot-dev-pack ms-azuretools.vscode-docker usernamehw.errorlens"
for EXT in $EXT_LIST;
    do /usr/local/bin/install-extension $EXT;
done
