use Mix.Config

config :geek, ecto_repos: [Geek.Repo]

import_config "#{Mix.env}.exs"
