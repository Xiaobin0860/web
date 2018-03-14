use Mix.Config

# Configure your database
config :geek, Geek.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "root",
  password: "123456",
  database: "geek_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
