defmodule HelloPhoenix.User.CommentController do
  use HelloPhoenix.Web, :controller

  alias HelloPhoenix.Comment

  def index(conn, _params) do
    comments = Comment
    |> Repo.all
    |> Repo.preload(:article)

    render(conn, "index.html", comments: comments)
  end

  def new(conn, _params) do
    changeset = Comment.changeset(%Comment{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"comment" => comment_params}) do
    changeset = Comment.changeset(%Comment{}, comment_params)

    case Repo.insert(changeset) do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: user_comment_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Repo.get!(Comment, id)
    render(conn, "show.html", comment: comment)
  end

  def edit(conn, %{"id" => id}) do
    comment = Repo.get!(Comment, id)
    changeset = Comment.changeset(comment)
    render(conn, "edit.html", comment: comment, changeset: changeset)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Repo.get!(Comment, id)
    changeset = Comment.changeset(comment, comment_params)

    case Repo.update(changeset) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "评论更新成功。")
        |> redirect(to: user_comment_path(conn, :index))
      {:error, changeset} ->
        render(conn, "edit.html", comment: comment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Repo.get!(Comment, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(comment)

    conn
    |> put_flash(:info, "评论删除成功。")
    |> redirect(to: user_comment_path(conn, :index))
  end
end
