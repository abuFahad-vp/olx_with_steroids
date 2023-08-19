using Genie, Genie.Router, Genie.Renderer.Html, Genie.Requests, SQLite

include("../pages/signup.html")
include("../pages/login.html")
include("../pages/redirect_signup_login.html")

database_path = "database/vendor.db"


route("/login") do
  html(login_form(""))
end

route("/login",method=POST) do

  email = postpayload(:email, "")
  password = postpayload(:password, "")

  println(email," ",password)

  db = SQLite.DB(database_path)

  command = """
  SELECT * FROM vendor
  WHERE email LIKE '$(email)';
  """
  isemail = false
  ispassword = false

  for row in DBInterface.execute(db,command)
      count = 0
      for value in row
          if count == 4
              if password == value
                isemail = true
                ispassword = true
              else
                isemail = true
              end
          end
          count +=1
      end
  end

  SQLite.close(db)
  if ispassword
    html("Successfully logged")
  else
    if !isemail html(login_form("Email not found")) 
    else
      html(login_form("Incorrect Password"))
    end
  end
end

route("/",method=GET) do
  redirect("/login")
end

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

  db = SQLite.DB(database_path)

  SQLite.execute(db, """
    INSERT INTO vendor (storeName,storeAddress,contactNumber,password,email)
    VALUES ('$storeName', '$storeAddress', $contactNumber,'$password','$email');
  """)

  SQLite.close(db)

  html(rd)

end

up()