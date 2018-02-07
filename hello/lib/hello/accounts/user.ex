defmodule Hello.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hello.Accounts.User


  schema "users" do
    field :account, :string
    field :nick, :string
    field :passwd, :string
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:nick, :account, :passwd])
    |> validate_required([:nick, :account, :passwd])
  end
end
