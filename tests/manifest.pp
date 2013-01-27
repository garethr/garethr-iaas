server { 'test-brightbox':
  ensure    => present,
  provider  => brightbox,
  image     => 'img-q6gc8', # ubuntu 12.04
  user_data => 'user-data-sample.sh',
}

server { 'test-rackspace':
  ensure    => present,
  provider  => rackspace,
  image     => '5cebb13a-f783-4f8c-8058-c4182c724ccd', # ubuntu 12.04
  flavor    => 2, # 512 MB
  count     => 2,
}
