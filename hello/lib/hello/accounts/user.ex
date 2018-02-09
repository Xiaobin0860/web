defmodule Hello.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hello.Accounts.User
  alias Comeonin.Pbkdf2

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
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{passwd: plain_text_passwd}} = changeset) do
    change(changeset, passwd: Pbkdf2.hashpwsalt(plain_text_passwd))
  end
  defp put_pass_hash(changeset), do: changeset
end
