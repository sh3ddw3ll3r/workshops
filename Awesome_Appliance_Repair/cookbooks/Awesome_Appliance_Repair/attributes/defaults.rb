default[:software] = {
  :apt => {
    :packages => [
        'libapache2-mod-wsgi',
        'python-pip',
        'python-mysqldb',
        'zip',
        'unzip'
   ]
  }
}

default['git']['repourl'] = 'https://github.com/learnchef/middleman-blog.git'
default['app']['name']    = 'middleman-blog'
default['ruby']['version'] = '2.1.5'