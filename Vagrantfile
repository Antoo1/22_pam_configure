MACHINES = {
  :"pam" => {
              :box_name => "ubuntu/jammy64",
              :cpus => 1,
              :memory => 512,
              :ip => "192.168.56.111",
            }
}

Vagrant.configure("2") do |config|
  MACHINES.each do |boxname, boxconfig|
    config.vm.synced_folder ".", "/vagrant", disabled: true
    config.vm.network "private_network", ip: boxconfig[:ip]
    config.vm.network "forwarded_port", guest: 22, host: 22222
    config.vm.define boxname do |box|
      box.vm.box = boxconfig[:box_name]
      box.vm.box_version = boxconfig[:box_version]
      box.vm.host_name = boxname.to_s

      box.vm.provider "virtualbox" do |v|
        v.memory = boxconfig[:memory]
        v.cpus = boxconfig[:cpus]
      end
      box.vm.provision "shell", inline: <<-SHELL
          sed -i 's/^PasswordAuthentication.*$/PasswordAuthentication yes/' $(grep -r 'PasswordAuthentication' /etc/ssh/ | awk '{print $1}' FS=':' | uniq)
          systemctl restart sshd.service
          useradd otusadm && sudo useradd otus
          echo otus:'Otus2022!' | sudo chpasswd
          echo otusadm:'Otus2022!' | sudo chpasswd
          groupadd -f admin
          usermod otusadm -a -G admin && usermod root -a -G admin && usermod vagrant -a -G admin
  	  SHELL
    end
  end
end

