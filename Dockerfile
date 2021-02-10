FROM jenkins/jenkins
LABEL maintainer="accounttolearn"
ENV AREA_DE_TRABALHO=/var/jenkins
ENV CAMINHO_ID_RSA=$AREA_DE_TRABALHO/.ssh/id_rsa
COPY --chown=jenkins:jenkins . $AREA_DE_TRABALHO
WORKDIR $AREA_DE_TRABALHO
USER root
RUN echo "IdentityFile $CAMINHO_ID_RSA" >> /etc/ssh/ssh_config
RUN chmod 600 $CAMINHO_ID_RSA
RUN git config --global user.email $(cat my_email.txt)
RUN git config --global user.name accountToLearn
RUN apt-get update && apt-get install -y \
      maven \
      dos2unix
RUN dos2unix $AREA_DE_TRABALHO/scripts/configurarNoJenkinsAposGeracaoDoPacote.sh
VOLUME $AREA_DE_TRABALHO
