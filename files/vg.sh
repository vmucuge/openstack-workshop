sudo vgs | grep cinder-volumes > /dev/null
  if [ $? -ne 0 ] ; then
  sudo pvcreate /dev/sdb
  sudo vgcreate cinder-volumes /dev/sdb
fi
