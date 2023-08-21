
route("/login") do
  html(login_form(""))
end

route("/login",method=POST) do

  email = postpayload(:email, "")
  password = postpayload(:password, "")

  println(email," ",password)
  loginAuth(email,password)
end

# return the html of the result of login credentials
function loginAuth(email,password)
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

  if ispassword return html("Successfully logged")
  else
    if !isemail return html(login_form("Email not found")) 
    else
      return html(login_form("Incorrect Password"))
    end
  end
end