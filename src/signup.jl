
route("/signup") do
  html(signup)
end

route("/signup", method = POST) do

  storeName = postpayload(:storeName, "")
  storeAddress = postpayload(:storeAddress, "")
  contactNumber = postpayload(:contactNumber, "")
  password = postpayload(:password,"")
  email = postpayload(:email, "")

  println("$storeName\n$storeAddress")
  println("$password\n$contactNumber\n$email")

  userCredentialsInput(storeName,storeAddress,contactNumber,password,email)

  # html page to redirect to login page
  html(rd)

end

# input the new user data to the database
function userCredentialsInput(storeName,storeAddress,contactNumber,password,email)
  db = SQLite.DB(database_path)
  SQLite.execute(db, """
    INSERT INTO vendor (storeName,storeAddress,contactNumber,password,email)
    VALUES ('$storeName', '$storeAddress', $contactNumber,'$password','$email');
  """)
  SQLite.close(db)
end
