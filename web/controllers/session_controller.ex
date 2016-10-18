defmodule HelloPhoenix.SessionController do
  use HelloPhoenix.Web, :controller

  alias HelloPhoenix.{User}
  
  def new(conn, _params) do
    changeset = User.changeset(%User{})
    conn
    |> assign(:changeset, changeset)
    |> render("new.html")
  end
  
  def create(conn, %{"user" => %{"name" => name, "password" => password}}) do
    user = User
    |> Repo.get_by!(name: name)
    
    if user.password == password do
      conn
      |> put_flash(:info, "登陆成功")
      |> redirect(to: session_path(conn, :home))
    end

    changeset = User.changeset(%User{})
    conn
    |> assign(:changeset, changeset)
    |> put_flash(:error, "登陆失败")
    |> render("new.html")
  end

  def home(conn, _params) do
    render conn, "home.html"
  end
end
