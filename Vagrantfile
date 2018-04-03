Vagrant.configure("2") do |config|
  config.vm.define "google-assistant-sdk"

  config.vm.box = "debian/contrib-stretch64"

  config.vm.hostname = "assistant"

  config.vm.provider :virtualbox do |vb|
    vb.customize "pre-boot", [
      "modifyvm", :id,
      "--audio", "coreaudio",
      "--audiocontroller", "ac97",
    ]
  end

  config.vm.provision :shell do |sh|
    sh.inline = <<-EOT
      apt-get -q update
      apt-get -q -y install alsa-utils
      /usr/sbin/alsactl init || true
    EOT
  end

  config.vm.provision :shell do |sh|
    sh.inline = <<-EOT
      apt-get -q update
      apt-get -q -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common
      curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
      apt-key fingerprint 0EBFCD88
      add-apt-repository \
         "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
      apt-get -q update
      apt-get -q -y install docker-ce
      usermod -aG docker vagrant
      systemctl start docker
    EOT
  end

  config.vm.provision :docker do |docker|
    docker.build_image "/vagrant",
      args: "-t ailispaw/google-assistant-sdk"
  end
end
