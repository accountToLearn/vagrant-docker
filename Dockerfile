FROM jenkins/jenkins
LABEL maintainer="accounttolearn"
ARG GITNOME= GITEMAIL=
ENV AREA_DE_TRABALHO=/var/jenkins/ CAMINHO_ID_RSA=${AREA_DE_TRABALHO}.ssh/id_rsa \
  CAMINHO_CONFIGURAR_GIT=${AREA_DE_TRABALHO}scripts/configurarGit.sh
COPY --chown=jenkins:jenkins . $AREA_DE_TRABALHO
WORKDIR $AREA_DE_TRABALHO
USER root
RUN ssh-keygen -t rsa -f $CAMINHO_ID_RSA -P ""; \
      echo "IdentityFile $CAMINHO_ID_RSA" >> /etc/ssh/ssh_config; \
        chmod 600 $CAMINHO_ID_RSA
RUN apt-get update && apt-get install -y \
      maven \
      dos2unix
RUN dos2unix ${AREA_DE_TRABALHO}scripts/configurarNoJenkinsAposGeracaoDoPacote.sh $CAMINHO_CONFIGURAR_GIT
RUN /bin/bash $CAMINHO_CONFIGURAR_GIT $GITNOME $GITEMAIL
VOLUME ${AREA_DE_TRABALHO}volumes
