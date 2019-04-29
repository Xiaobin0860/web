defmodule Blog.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :account, :string
      add :pass, :string
      add :nick, :string
      add :email, :string

      timestamps()
    end

  end
end
