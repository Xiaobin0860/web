defmodule Hello.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :nick, :string
      add :account, :string
      add :passwd, :string

      timestamps()
    end

  end
end
