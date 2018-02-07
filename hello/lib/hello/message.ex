defmodule Hello.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hello.Message


  schema "messages" do
    field :message, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Message{} = message, attrs) do
    message
    |> cast(attrs, [:name, :message])
    |> validate_required([:name, :message])
  end

  def get_msgs(limit \\ 20) do
    Hello.Repo.all(Message, limit: limit)
  end
end
