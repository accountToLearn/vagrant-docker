#!/bin/#!/usr/bin/env bash
echo "########## Entrando no Shell Scripting $0 ##########"
echo "------------------------------------------"
echo "    README          "
echo "------------------------------------------"
echo
echo "Para executar esse script, é preciso passar um argumento."
echo "Este argumento é o nome do ambiente"
echo "Bons exemplos de nomes:"
echo "int, hom, prd"
echo
CAMINHO_PROJETOS=/var/jenkins/volumes/projetos/$1/
CAMINHO_WORKSPACE=/var/jenkins_home/workspace/lista-de-mercado-$1/
CAMINHO_LOGS=/var/jenkins/volumes/logs/erros/
removerWar(){
	if [ $(ls $CAMINHO_PROJETOS | wc -l) -gt 0 ]
	then
		echo "########## Removendo WAR $(ls $CAMINHO_PROJETOS) ##########"
		rm -rf $CAMINHO_PROJETOS
		[ $? -eq 0 ] && echo "########## WAR removido com sucesso em $(ls $CAMINHO_PROJETOS) ##########" || \
		echo "########## Erro ao remover WAR $(ls $CAMINHO_PROJETOS) ##########"
	fi
}
removerWar 2>${CAMINHO_LOGS}removendoWar.log
copiarWar(){
	echo "########## Copiando WAR $(ls $CAMINHO_WORKSPACE) ##########"
	cp -r $CAMINHO_WORKSPACE $CAMINHO_PROJETOS
	[ $? -eq 0 ] && echo "########## WAR copiado com sucesso para $(ls $CAMINHO_PROJETOS) ##########" || \
	echo "########## Erro ao copiar war $(ls $CAMINHO_WORKSPACE) ##########"
}
copiarWar 2>${CAMINHO_LOGS}copiandoWar.log
echo "########## Saindo do Shell Scripting $0 ##########"
