# -*- mode: ruby -*-
# vi: set ft=ruby :

GUEST_NODE_VERSION = '0.10.36'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "forwarded_port", guest: 8000, host: 8000
  config.vm.network "forwarded_port", guest: 35729, host: 35729 # gulp-livereload
  config.vm.synced_folder (ENV['MOUNT'] || "."), "/vagrant"

  # 必要なパッケージとNodeをインストール
  config.vm.provision "shell", privileged: true, inline: <<-__SCRIPT__
    export DEBIAN_FRONTEND=noninteractive
    apt-get update -y
    apt-get install -y git build-essential automake libtool

    if [ ! -x "/usr/local/node-v#{GUEST_NODE_VERSION}-linux-x64/bin/node" ]; then
      cd /tmp
      wget --quiet http://nodejs.org/dist/v#{GUEST_NODE_VERSION}/node-v#{GUEST_NODE_VERSION}-linux-x64.tar.gz
      tar xfz node-v#{GUEST_NODE_VERSION}-linux-x64.tar.gz -C /usr/local
      rm node-v#{GUEST_NODE_VERSION}-linux-x64.tar.gz
      echo "export PATH=\"/usr/local/node-v#{GUEST_NODE_VERSION}-linux-x64/bin:\\$PATH\"" >> /home/vagrant/.profile
    fi

    if [ ! -f "/usr/local/lib/libsass.a" ]; then
      cd /tmp
      git clone https://github.com/sass/libsass.git
      git clone https://github.com/sass/sassc.git libsass/sassc

      cd /tmp/libsass
      autoreconf --force --install
      ./configure \
        --disable-tests \
        --enable-shared \
        --prefix=/usr/local
      cd /tmp
      make -C libsass install

      cd /tmp
      rm -Rf /tmp/libsass
    fi
  __SCRIPT__

  config.vm.provision "shell",  privileged: false, inline: <<-__SCRIPT__
    export PATH="/usr/local/node-v#{GUEST_NODE_VERSION}-linux-x64/bin:$PATH"
    cd /vagrant
    npm install && ./bin/bower install
  __SCRIPT__

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", 1024]
  end
end
