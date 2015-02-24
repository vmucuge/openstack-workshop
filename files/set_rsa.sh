if [ ! -d /root/.ssh ] ; then
  sudo mkdir -p /root/.ssh/
fi
sudo cp /vagrant/files/id_rsa* /root/.ssh/
sudo chmod 600 /root/.ssh/id_rsa
sudo chmod 640 /root/.ssh/id_rsa.pub
sudo cp /vagrant/files/authorized_keys /root/.ssh/authorized_keys
sudo chmod 750 /root/.ssh/
