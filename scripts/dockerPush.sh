#!/bin/#!/usr/bin/env bash
echo '########## Entrando no Shell Scripting ##########'
if [ ! -d ~/logs ]
then
  mkdir ~/logs
  echo "########### Diretorio LOGS criado com sucesso ###########"
fi
copiarCredencialDocker(){
  cp /vagrant/my_password.txt ~
}
copiarCredencialDocker 2>~/logs/copiarCredencialDocker.log
if [ $? -eq 0 ]
then
  echo "########### Credencial copiada com sucesso ###########"
else
  echo "########### Erro ao copiar credencial ###########"
fi
extrairCredencialDocker(){
  cat ~/my_password.txt | docker login -u accounttolearn --password-stdin
}
extrairCredencialDocker 2>~/logs/extrairCredencialDocker.log
if [ $? -eq 0 ]
then
  echo '########## Arquivo extraido com sucesso ##########'
else
  echo '########## Erro ao extrair arquivo ##########'
fi
subindoImagemCriada(){
  docker tag accounttolearn/jenkins-and-maven accounttolearn/jenkins-and-maven
  docker push accounttolearn/jenkins-and-maven
}
subindoImagemCriada 2>~/logs/subindoImagemCriada.log
if [ $? -eq 0 ]
then
  echo '########## Imagem gerada com sucesso ##########'
else
  echo '########## Erro na imagem gerada ##########'
fi
echo '########## Saindo do Shell Scripting ##########'
