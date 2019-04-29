defmodule Blog.GenJsons.Json do
  use Ecto.Schema
  import Ecto.Changeset


  schema "jsons" do
    field :test, :string

    timestamps()
  end

  @doc false
  def changeset(json, attrs) do
    json
    |> cast(attrs, [:test])
    |> validate_required([:test])
  end
end
