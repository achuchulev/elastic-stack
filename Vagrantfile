Vagrant.configure("2") do |config|
  config.vm.define vm_name = "elastic" do |node|
    node.vm.box = "achuchulev/xenial64"
    node.vm.hostname = "elastic"
    node.vm.network "forwarded_port", guest: 5601, host: 5601, auto_correct: true
    node.vm.provision :shell, path: "provision/elastic.sh"
    node.vm.network "private_network", ip: "192.168.57.57"
    node.vm.provider "virtualbox" do |vb|
     vb.memory = "1024"
    end
  end

  config.vm.define vm_name = "nginx" do |web|
    web.vm.box = "achuchulev/xenial64"
    web.vm.hostname = "nginx"
    web.vm.provision :shell, path: "provision/nginx.sh"
    web.vm.network "private_network", ip: "192.168.57.58"
    web.vm.provider "virtualbox" do |vb|
     vb.memory = "1024"
    end
  end
end
