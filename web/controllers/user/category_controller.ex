defmodule HelloPhoenix.User.CategoryController do
  use HelloPhoenix.Web, :controller

  alias HelloPhoenix.Category

  def index(conn, _params) do
    categorys = Repo.all(Category)
    render(conn, "index.html", categorys: categorys)
  end

  def new(conn, _params) do
    changeset = Category.changeset(%Category{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"category" => category_params}) do
    changeset = Category.create_changeset(%Category{}, category_params)

    case Repo.insert(changeset) do
      {:ok, _category} ->
        conn
        |> put_flash(:info, "范畴创建成功。")
        |> redirect(to: user_category_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    category = Repo.get!(Category, id)
    render(conn, "show.html", category: category)
  end

  def edit(conn, %{"id" => id}) do
    category = Repo.get!(Category, id)
    changeset = Category.changeset(category)
    render(conn, "edit.html", category: category, changeset: changeset)
  end

  def update(conn, %{"id" => id, "category" => category_params}) do
    category = Repo.get!(Category, id)
    changeset = Category.changeset(category, category_params)

    case Repo.update(changeset) do
      {:ok, _category} ->
        conn
        |> put_flash(:info, "范畴更新成功。")
        |> redirect(to: user_category_path(conn, :index))
      {:error, changeset} ->
        render(conn, "edit.html", category: category, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    category = Repo.get!(Category, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(category)

    conn
    |> put_flash(:info, "范畴删除成功。")
    |> redirect(to: user_category_path(conn, :index))
  end
end
