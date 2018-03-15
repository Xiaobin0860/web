defmodule Sling.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Comeonin.Pbkdf2

  schema "users" do
    field :email, :string
    field :nick, :string
    field :pass, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:nick, :email, :pass])
    |> validate_required([:nick, :email, :pass])
    |> unique_constraint(:nick)
    |> unique_constraint(:email)
    |> validate_length(:pass, min: 6, max: 100)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{pass: plain_text_passwd}} = changeset) do
    change(changeset, pass: Pbkdf2.hashpwsalt(plain_text_passwd))
  end
  defp put_pass_hash(changeset), do: changeset
end
