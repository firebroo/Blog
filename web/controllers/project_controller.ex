defmodule HelloPhoenix.ProjectController do
  use HelloPhoenix.Web, :controller

  def index(conn, _params) do
    conn
    |> render(:index)
  end
end
