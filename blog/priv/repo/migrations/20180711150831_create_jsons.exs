defmodule Blog.Repo.Migrations.CreateJsons do
  use Ecto.Migration

  def change do
    create table(:jsons) do
      add :test, :string

      timestamps()
    end

  end
end
