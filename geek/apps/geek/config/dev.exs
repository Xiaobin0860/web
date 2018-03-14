use Mix.Config

# Configure your database
config :geek, Geek.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "root",
  password: "123456",
  database: "geek_dev",
  hostname: "localhost",
  pool_size: 10
