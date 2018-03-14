defmodule Geek.Application do
  @moduledoc """
  The Geek Application Service.

  The geek system business domain lives in this application.

  Exposes API to clients such as the `GeekWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(Geek.Repo, []),
    ], strategy: :one_for_one, name: Geek.Supervisor)
  end
end
