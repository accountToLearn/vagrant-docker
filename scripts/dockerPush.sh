#!/bin/#!/usr/bin/env bash
echo "########## Entrando no Shell Scripting $0 ##########"
echo "------------------------------------------"
echo "    README          "
echo "------------------------------------------"
echo
echo "Para executar esse script, é preciso passar dois argumentos."
echo "O primeiro argumento é o caminho onde fica o arquivo my_password.txt"
echo "O segundo argumento é o nome para docker tag."
echo "Por exemplo: "
echo "1) /vagrant/ ou /home/docker/"
echo "2) accounttolearn/jenkins-and-maven ou accounttolearn/marketlist"
echo
CAMINHO_PWD=$1 NOME_DOCKER_TAG=$2
CAMINHO_VOLUMES=${CAMINHO_PWD}volumes/
CAMINHO_LOG_ERRO=${CAMINHO_VOLUMES}logs/erro/
extrairCredencialDocker(){
  cat ${CAMINHO_PWD}my_password.txt | docker login -u accounttolearn --password-stdin
}
extrairCredencialDocker 2>${CAMINHO_LOG_ERRO}extrairCredencialDocker.log
[ $? -eq 0 ] && echo "########## Arquivo extraido com sucesso ##########" || echo "########## Erro ao extrair arquivo ##########"
subindoImagemCriada(){
  docker tag $NOME_DOCKER_TAG $NOME_DOCKER_TAG
  docker push $NOME_DOCKER_TAG
}
subindoImagemCriada 2>${CAMINHO_LOG_ERRO}subindoImagemCriada.log
[ $? -eq 0 ] && echo "########## Imagem gerada com sucesso $2 ##########" || echo "########## Erro na imagem gerada $2 ##########"
echo "########## Saindo do Shell Scripting $0 ##########"
