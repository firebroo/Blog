defmodule HelloPhoenix.CommentController do
    use HelloPhoenix.Web, :controller
    
    alias HelloPhoenix.{Comment, Article}

    def create(conn, %{"category_id" => category_id, "article_id" => article_hash_id, "comment" => comment_params}) do
        article = Article |> where(hash_id: ^article_hash_id) |> Repo.one!
        comment_params = comment_params
        |> Map.put("article_id", article.id)

        changeset = Comment.changeset(%Comment{}, comment_params)
        case Repo.insert(changeset) do
             {:ok, _comment} ->
                conn
                |> put_flash(:info, "评论提交成功.")
             {:error, _changeset} ->
                conn
                |> put_flash(:error, "评论提交失败")
        end
        |> redirect(to: category_article_path(conn, :show, category_id, article_hash_id))
    end

end
