#!/bin/#!/usr/bin/env bash
CAMINHO_LOG_ERRO=/vagrant/volumes/logs/erro/
echo '########## Entrando no Shell Scripting ##########'
copiarCredencialDocker(){
  cp /vagrant/my_password.txt ~
}
copiarCredencialDocker 2>>$CAMINHO_LOG_ERRO'dockerPush-copiarCredencialDocker.log'
if [ $? -eq 0 ]
then
  echo "########### Credencial copiada com sucesso ###########"
else
  echo "########### Erro ao copiar credencial ###########"
fi
extrairCredencialDocker(){
  cat ~/my_password.txt | docker login -u accounttolearn --password-stdin
}
extrairCredencialDocker 2>>$CAMINHO_LOG_ERRO'extrairCredencialDocker.log'
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
subindoImagemCriada 2>>$CAMINHO_LOG_ERRO'subindoImagemCriada.log'
if [ $? -eq 0 ]
then
  echo '########## Imagem gerada com sucesso ##########'
else
  echo '########## Erro na imagem gerada ##########'
fi
echo '########## Saindo do Shell Scripting ##########'
