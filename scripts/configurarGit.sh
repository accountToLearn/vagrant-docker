#!/bin/#!/usr/bin/env bash
echo "########## Configurando git user.name $1 ##########"
git config --global user.name $1
echo "########## Configurando git user.email $2 ##########"
git config --global user.email $2
