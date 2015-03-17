# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "vcore-i486-core5.0.2-c"
  config.vm.box_url = "https://github.com/hyamamoto/virtual-core/releases/download/0.5/vcore-0.5-i486-core5.0.2-c.box"
  #config.vm.box = "olbat/tiny-core-micro"
  config.vm.network "forwarded_port", guest: 8000, host: 8000
  config.vm.network "forwarded_port", guest: 35729, host: 35729 # gulp-livereload
  config.vm.synced_folder ".", "/vagrant"
  config.vm.provision :shell, :inline => <<-__SCRIPT__
    [ -x /usr/local/bin/git ] || su -c "tce-load -wi git" - tc

    if [ ! -x "/usr/local/node-v0.12.0-linux-x86/bin/node" ]; then
      cd /tmp
      wget http://nodejs.org/dist/v0.12.0/node-v0.12.0-linux-x86.tar.gz
      tar xfz node-v0.12.0-linux-x86.tar.gz -C /usr/local
      rm node-v0.12.0-linux-x86.tar.gz
      echo "export PATH=/usr/local/node-v0.12.0-linux-x86/bin:\\$PATH">> /home/tc/.profile
    fi
  __SCRIPT__
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", 512]
  end
  config.ssh.default.username = "tc"
  config.ssh.shell = "sh"
  config.ssh.guest_port = 22
  config.ssh.forward_agent = true
  config.ssh.forward_x11 = false
  config.ssh.keep_alive = true
end
