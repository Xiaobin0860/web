defmodule Sling.Accounts.Player do
  use Ecto.Schema
  import Ecto.Changeset


  schema "players" do
    field :account, :string
    field :nick, :string
    field :pass, :string

    timestamps()
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [:nick, :account, :pass])
    |> validate_required([:nick, :account, :pass])
    |> unique_constraint(:nick)
    |> unique_constraint(:account)
  end
end
