defmodule Hello.Accounts.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :hello,
    error_handler: Hello.Accounts.ErrorHandler,
    module: Hello.Accounts.Guardian

  plug(Guardian.Plug.VerifySession, claims: %{"typ" => "access"})
  plug(Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"})
  plug(Guardian.Plug.LoadResource, allow_blank: true)
end
