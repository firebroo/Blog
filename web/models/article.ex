defmodule HelloPhoenix.Article do
  use HelloPhoenix.Web, :model

  schema "articles" do
    field :title, :string
    field :body, :string
    belongs_to :category, HelloPhoenix.Category

    has_many :comments, HelloPhoenix.Comment

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :body, :category_id])
    |> validate_required([:title, :body])
  end
end
