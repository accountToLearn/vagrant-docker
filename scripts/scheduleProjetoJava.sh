#!/bin/#!/usr/bin/env bash
CAMINHO_PROJETO_ESPELHADO=/vagrant/volumes/projetos/
CAMINHO_PROJETO_VM=/home/vagrant/projetos/
CAMINHO_DOCKERFILE=$CAMINHO_PROJETO_ESPELHADO$(ls $CAMINHO_PROJETO_ESPELHADO)/Dockerfile
removerDocker() {
  echo "########## Removendo container e imagem docker ##########"
  docker rm -f java
  docker rmi java
}
criarExecutarImagemDocker() {
  echo "########## Executando docker build e docker run ##########"
  inicio_tempo=$(date +%s)
  docker build -t java ~/projetos/$(ls $CAMINHO_PROJETO_VM)/
  docker run -d -t --name java --restart=always -p 9000:9000 -v '/vagrant/volumes:/var/www/volumes' java
  tempo_gasto=$(($(date +%s) - $inicio_tempo))
  final_tempo=`echo "scale=2; $tempo_gasto / 60" | bc -l`
  echo "########## Tempo gasto para criar imagem e container foi: $final_tempo minutos ##########"
}
limparCrontab() {
  echo "########## Limpando crontab ##########"
  crontab -r
}
adicionarMonitoriaNoCrontab() {
  echo "########## Schedule do projeto ##########"
  (crontab -u vagrant -l; echo "* * * * * sh /vagrant/scripts/scheduleProjetoJava.sh > /vagrant/logs/timeLineScheduleProjeto.log 2>&1") \
  | crontab -u vagrant -
}
scheduleProjeto() {
  echo "############################## $(date) ##############################"
  limparCrontab
  if [ $? -eq 0 ];then
    echo "########## Crontab limpo com sucesso ##########"
  else
    echo "########## Erro ao limpar crontab ##########"
  fi
  echo "########## Verificando a existencia do projeto ##########"
  echo "Caminho do local --> $(ls $CAMINHO_PROJETO_ESPELHADO | wc -l) --> $(ls -l $CAMINHO_PROJETO_ESPELHADO)"
  echo "Caminho da VM --> $(ls $CAMINHO_PROJETO_VM | wc -l) --> $(ls -l $CAMINHO_PROJETO_VM)"
  if ([ $(ls $CAMINHO_PROJETO_ESPELHADO | wc -l) -gt 0 ] && [ $(ls $CAMINHO_PROJETO_VM | wc -l) -gt 0 ] && [ -e "$CAMINHO_DOCKERFILE" ] \
  && [ "$CAMINHO_PROJETO_ESPELHADO$(ls $CAMINHO_PROJETO_ESPELHADO)/" -nt "$CAMINHO_PROJETO_VM$(ls $CAMINHO_PROJETO_VM)/" ]) \
  || ([ $(ls $CAMINHO_PROJETO_ESPELHADO | wc -l) -gt 0 ] && [ -e "$CAMINHO_DOCKERFILE" ] && [ $(ls $CAMINHO_PROJETO_VM | wc -l) -eq 0 ]);then
    echo "########## Projeto encontrado com sucesso ##########"
    removerDocker
    if [ $? -eq 0 ];then
      echo "########## Container e imagem removida com sucesso ##########"
    else
      echo "########## Erro ao remover container e imagem ##########"
    fi
    echo "########## Copiando projeto para VM ##########"
    cp -r $CAMINHO_PROJETO_ESPELHADO ~/
    criarExecutarImagemDocker
    if [ $? -eq 0 ];then
      echo "########## Imagem criada e executada com sucesso ##########"
    else
      echo "########## Erro ao criar e executar imagem ##########"
    fi
  else
    echo "########## Erro ao encontrar o projeto ##########"
  fi
  adicionarMonitoriaNoCrontab
  if [ $? -eq 0 ];then
    echo "########## Monitoria agendada com sucesso ##########"
  else
    echo "########## Erro ao agendar monitoria ##########"
  fi
}
scheduleProjeto 2>/vagrant/logs/erroScheduleProjetoJava.log
if [ $? -ne 0 ];then
  adicionarMonitoriaNoCrontab
  echo "########## Erro do schedule projeto ##########"
fi
