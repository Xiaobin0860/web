defmodule Sling.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :nick, :string, null: false
      add :account, :string, null: false
      add :pass, :string, null: false

      timestamps()
    end

    create unique_index(:players, :nick)
    create unique_index(:players, :account)
  end
end
