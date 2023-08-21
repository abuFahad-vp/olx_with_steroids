using Genie, Genie.Router, Genie.Renderer.Html, Genie.Requests, SQLite

include("../pages/signup.html")
include("../pages/login.html")
include("../pages/redirect_signup_login.html")
include("constants.jl")
include("login.jl")
include("signup.jl")


route("/",method=GET) do
  redirect("/login")
end

up()