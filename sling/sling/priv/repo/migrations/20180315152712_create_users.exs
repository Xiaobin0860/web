defmodule Sling.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :nick, :string, null: false
      add :email, :string, null: false
      add :pass, :string, null: false

      timestamps()
    end

    create unique_index(:users, :nick)
    create unique_index(:users, :email)
  end
end
