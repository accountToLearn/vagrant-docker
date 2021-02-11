Vagrant.configure("2") do |config|
  config.vm.define :docker do |docker_config|
    docker_config.vm.box = "bento/ubuntu-20.04"
    #Intalar vagrant plugin install vagrant-disksize
    docker_config.disksize.size = '30GB'
    docker_config.vm.network "forwarded_port", guest: 8080, host: 8080
    docker_config.vm.network "forwarded_port", guest: 9000, host: 9000
    docker_config.vm.network "private_network", ip: "192.168.2.2"
    docker_config.vm.provision "docker" do |d|
      d.build_image "/vagrant/",
        args: "-t accounttolearn/jenkins-and-maven"
      d.run "accounttolearn/jenkins-and-maven",
        args: "--network=host --name jenkins -v '/vagrant/volumes:/var/jenkins/volumes'"
    end
    docker_config.vm.provision "shell", inline: "apt-get update && apt-get install -y dos2unix docker-compose"
    docker_config.vm.provision "shell", inline: "dos2unix /vagrant/scripts/scheduleProjetoJava.sh && \
                                                    sh /vagrant/scripts/scheduleProjetoJava.sh"
    docker_config.vm.provider "virtualbox" do |vb|
      vb.memory = 2048
      vb.cpus = 2
      vb.name = "integracao_docker"
    end
    #docker_config.vm.provision "shell", inline: "sh /vagrant/scripts/dockerPush.sh"
  end
end
