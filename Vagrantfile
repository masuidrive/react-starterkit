# -*- mode: ruby -*-
# vi: set ft=ruby :


GUEST_NODE_VERSION = "0.12.2"

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "vcore-i486-core5.0.2-c"
  config.vm.box_url = "https://github.com/hyamamoto/virtual-core/releases/download/0.5/vcore-0.5-i486-core5.0.2-c.box"
  #config.vm.box = "olbat/tiny-core-micro"
  config.vm.network "forwarded_port", guest: 8000, host: 8000
  config.vm.network "forwarded_port", guest: 35729, host: 35729 # gulp-livereload
  config.vm.synced_folder ".", "/vagrant"
  config.vm.provision :shell, privileged: true, :inline => <<-__SCRIPT__
    [ -x /usr/local/bin/git ] || su -c "tce-load -wi git" - tc

    if [ ! -x "/usr/local/node-v#{GUEST_NODE_VERSION}-linux-x86/bin/node" ]; then
      cd /tmp
      wget --quiet http://nodejs.org/dist/v#{GUEST_NODE_VERSION}/node-v#{GUEST_NODE_VERSION}-linux-x86.tar.gz
      tar xfz node-v#{GUEST_NODE_VERSION}-linux-x86.tar.gz -C /usr/local
      rm node-v#{GUEST_NODE_VERSION}-linux-x86.tar.gz
      echo "export PATH=/usr/local/node-v#{GUEST_NODE_VERSION}-linux-x86/bin:\\$PATH">> /home/tc/.profile
    fi
  __SCRIPT__
  
  config.vm.provision :shell, privileged: false, :inline => <<-__SCRIPT__
    export PATH="/usr/local/node-v#{GUEST_NODE_VERSION}-linux-x86/bin:$PATH"
    cd /vagrant
    npm install && ./bin/bower install
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
