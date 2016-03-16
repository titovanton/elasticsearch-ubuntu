Vagrant.configure(2) do |config|
    config.vm.box = "ubuntu/trusty64"
    # config.vm.network :forwarded_port, guest: 80, host: 4567
    # config.vm.synced_folder ".", "/webapps"
    config.vm.network "private_network", ip: "10.10.10.46"
    config.vm.provision :shell, path: "bootstrap.sh"

    config.vm.provider "virtualbox" do |v|
        v.cpus = 4
        v.customize ["modifyvm", :id, "--cpuexecutioncap", "80"]
        v.memory = 2048
        v.name = "es-testbase"
    end
end
