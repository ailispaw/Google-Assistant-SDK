Vagrant.configure("2") do |config|
  config.vm.define "google-assistant-sdk"

  config.vm.box = "debian/contrib-stretch64"

  config.vm.hostname = "assistant"

  config.vm.provider :virtualbox do |vb|
    vb.customize "pre-boot", [
      "modifyvm", :id,
      "--audio", "coreaudio",
      "--audiocontroller", "hda",
    ]
  end

  config.vm.provision :shell do |sh|
    sh.privileged = false
    sh.inline = <<-EOT
      sudo apt-get -q update
      sudo apt-get -q -y install alsa-utils python3-dev python3-venv
      python3 -m venv env
      env/bin/pip install --upgrade pip setuptools wheel

      sudo apt-get -q -y install portaudio19-dev libffi-dev libssl-dev
      env/bin/pip install --upgrade google-assistant-library
      env/bin/pip install --upgrade google-assistant-sdk[samples]
      env/bin/pip install --upgrade google-auth-oauthlib[tool]
    EOT
  end
end
