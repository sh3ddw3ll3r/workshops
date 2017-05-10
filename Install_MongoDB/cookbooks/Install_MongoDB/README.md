# Install_MongoDB

### Recipes
* install_mongodb.rb
    * Configures Yum to use the MongoDb repo. Template mongodb.repo.erb has logic to create the file based on the computer's architecture (32-bit/64-bit)
    * Installs MongoDB using Yum
* start_mongodb.rb
    * Start the MongoDb service, and sets it to autostart on server boot.

### Tests
* Implemented following tests (although the tests weren't executing during converge. I verified tehm by running the inspec test manually against the server after kitchen converge)
    * Verify MongoDb is installed
    * Verify MongoDb is running
    * Verify MongoDb is running under mongo user
