# Tomcat

### Attributes
* default.rb
    * default['tomcat']['group']        - Tomcat group name
    * default['tomcat']['groupgid']     - Tomcat group GID
    * default['tomcat']['user']         - Tomcat User
    * default['tomcat']['usergid']      - Tomcat user UID
    * default['tomcat']['password']     - Password for Tomcat user (better to be in a databag)
    * default['tomcat']['version']      - Tomcat version to be installed.
    * default['tomcat']['archivefile']  - Tomcat archive file name
    * default['tomcat']['archiveurl']   - URL for the Tomcat Archive File
    * default['tomcat']['installdir']   - Directory to which Tomcat will be installed.
    I used variable embedding to build up the Tomcat URl. I believe there is a better method than what I did because of Chef's variable scoping

### Templates
* tomcat.service.erb - defined service to control Tomcat

### Recipes
* install_java.rb   - install java utilizing Yum
* create_group.rb   - Create Tomcat group as defined in Attributes
* create_user.rb    - Create Tomcat user as defined in Attributes
* install_tomcat.rb - 
    * Download the Tomcat archive
    * Untar the archive to the Tomcat installation directory as defined in Attributes
    * Set permissions on the Tomcat install direcotry following guidance from [Tomcat Config Guide](https://tomcat.apache.org/tomcat-8.0-doc/security-howto.html#Non-Tomcat_settings)
    * Configure the Tomcat service using template tomcat.service.erb
    * Start Tomcat and enable the service to start on server boot.

