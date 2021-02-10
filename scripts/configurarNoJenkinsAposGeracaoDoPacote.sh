#!/bin/#!/usr/bin/env bash
CAMINHO_PROJETOS=/var/jenkins/volumes/projetos/
CAMINHO_WORKSPACE=/var/jenkins_home/workspace/
removerWar(){
	if [ $(ls $CAMINHO_PROJETOS | wc -l) -gt 0 ]
	then
		echo "########## Removendo WAR ##########"
		rm -rf $CAMINHO_PROJETOS*
		if [ $? -eq 0 ]
		then
			echo "########## Remocao do WAR realizada com sucesso ##########"
		else
			echo "########## Erro ao remover WAR ##########"
		fi
	fi
}
removerWar 2>/var/jenkins/logs/removendoWar.log
copiarWar(){
	echo "########## Copiando WAR ##########"
	cp -r $CAMINHO_WORKSPACE$(ls $CAMINHO_WORKSPACE) $CAMINHO_PROJETOS
}
copiarWar 2>/var/jenkins/logs/copiandoWar.log
if [ $? -eq 0 ]
then
	echo "########## WAR copiado com sucesso ##########"
else
	echo "########## Erro ao copiar war ##########"
fi
