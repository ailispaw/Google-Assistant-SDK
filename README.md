# Google Assistant SDK with Vagrant and VirtualBox

https://developers.google.com/assistant/sdk/overview

## Configure the Audio

You may need to change the Audio Host Driver using `--audio` in Vagrantfile as below.  
You can see the available selections in the Settings of VirtualBox Manager while the VM is stopping. 

```ruby
  config.vm.provider :virtualbox do |vb|
    vb.customize "pre-boot", [
      "modifyvm", :id,
      "--audio", "coreaudio",
      "--audiocontroller", "hda",
    ]
  end
```

Cf.) https://www.virtualbox.org/manual/ch08.html#vboxmanage-modifyvm-other

> --audio none|null|dsound|oss|alsa|pulse|coreaudio: With this setting, you can specify whether the VM should have audio support, and – if so – which type. The list of supported audio types depends on the host and can be determined with VBoxManage modifyvm.

> --audiocontroller ac97|hda|sb16: With this setting, you can specify the audio controller to be used with this VM.

## Boot up and Install the SDK and Sample Code

```
$ vagrant up
```

Cf.) https://developers.google.com/assistant/sdk/guides/library/python/embed/install-sample

## Test the Audio

```
$ vagrant reload
$ vagrant ssh
vagrant@assistant:~$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: STAC9221 A1 Analog [STAC9221 A1 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 1: STAC9221 A1 Digital [STAC9221 A1 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
vagrant@assistant:~$ arecord -l
**** List of CAPTURE Hardware Devices ****
card 0: Intel [HDA Intel], device 0: STAC9221 A1 Analog [STAC9221 A1 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 1: STAC9221 A1 Digital [STAC9221 A1 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 2: STAC9221 A1 Alt Analog [STAC9221 A1 Alt Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
vagrant@assistant:~$ amixer set Master 100%
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 127
  Mono: Playback 127 [100%] [0.00dB] [on]
vagrant@assistant:~$ aplay /usr/share/sounds/alsa/Front_Center.wav
Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Mono
```

## Configure a Developer Project and Account Settings

- Follow https://developers.google.com/assistant/sdk/guides/library/python/embed/config-dev-project-and-account

## Register a Device Model

- Follow https://developers.google.com/assistant/sdk/guides/library/python/embed/register-device
- Download a credentials file (OAuth2 client secret) and place it in this directory where the Vagrantfile is.

## Generate Credentials for the Google Assistant API

```
$ vagrant ssh
vagrant@assistant:~$ source env/bin/activate
(env) vagrant@assistant:~$ google-oauthlib-tool --scope https://www.googleapis.com/auth/assistant-sdk-prototype --save --headless --client-secrets /vagrant/credentials.json
```

Cf.) https://developers.google.com/assistant/sdk/guides/library/python/embed/install-sample#generate_credentials

## Run a Sample Code

```
(env) vagrant@assistant:~$ googlesamples-assistant-hotword --project_id aiy-voice-kit-196422 --device_model_id google-assistant-sdk-001
(env) vagrant@assistant:~$ googlesamples-assistant-pushtotalk --project-id aiy-voice-kit-196422 --device-model-id google-assistant-sdk-001 --lang ja_jp
```

Cf.)
- https://developers.google.com/assistant/sdk/guides/library/python/embed/run-sample
- https://developers.google.com/assistant/sdk/guides/service/python/embed/run-sample
