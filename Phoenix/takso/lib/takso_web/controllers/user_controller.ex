defmodule TaksoWeb.UserController do
  use TaksoWeb, :controller

  alias Takso.User
  
  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, "index.html", users: users)
  end
end
