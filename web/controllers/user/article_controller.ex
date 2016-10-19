defmodule HelloPhoenix.User.ArticleController do
  use HelloPhoenix.Web, :controller

  alias HelloPhoenix.{Article, Category}

  def index(conn, _params) do
    articles = Repo.all(Article)
    render(conn, "index.html", articles: articles)
  end

  def new(conn, _params) do
    categorys = Repo.all(Category)

    changeset = Article.changeset(%Article{})
    render(conn, "new.html", changeset: changeset, categorys: categorys)
  end

  def create(conn, %{"article" => article_params}) do
    changeset = Article.changeset(%Article{}, article_params)

    case Repo.insert(changeset) do
      {:ok, _article} ->
        conn
        |> put_flash(:info, "Article created successfully.")
        |> redirect(to: user_article_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    article = Repo.get!(Article, id)
    render(conn, "show.html", article: article)
  end

  def edit(conn, %{"id" => id}) do
    article = Repo.get!(Article, id)
    categorys = Repo.all(Category)
    #category = Repo.one Ecto.assoc(article, :category)
    # 过滤掉文章所属的范畴
    #categorys = Enum.filter(categorys, fn x -> x != category end)
    # 将当前文章所属的范畴放到第一
    #categorys = [category | categorys]
    changeset = Article.changeset(article)

    conn
    |> assign(:article, article)
    |> assign(:changeset, changeset)
    |> assign(:categorys, categorys)
    |> render("edit.html")
  end

  def update(conn, %{"id" => id, "article" => article_params}) do
    article = Repo.get!(Article, id)
    changeset = Article.changeset(article, article_params)

    case Repo.update(changeset) do
      {:ok, article} ->
        conn
        |> put_flash(:info, "Article updated successfully.")
        |> redirect(to: user_article_path(conn, :show, article))
      {:error, changeset} ->
        render(conn, "edit.html", article: article, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    article = Repo.get!(Article, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(article)

    conn
    |> put_flash(:info, "Article deleted successfully.")
    |> redirect(to: user_article_path(conn, :index))
  end
end