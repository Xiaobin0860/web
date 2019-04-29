defmodule Blog.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :account, :string
    field :email, :string
    field :nick, :string
    field :pass, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:account, :pass, :nick, :email])
    |> validate_required([:account, :pass, :nick, :email])
  end
end
