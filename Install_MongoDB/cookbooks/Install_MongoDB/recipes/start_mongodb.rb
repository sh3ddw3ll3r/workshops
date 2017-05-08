# start mongosdb, and set teh service to start on server boot
service "mongod" do
  action [:enable, :start]
end