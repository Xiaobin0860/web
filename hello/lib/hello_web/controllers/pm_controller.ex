defmodule HelloWeb.PmController do
  use HelloWeb, :controller

  alias Hello.Accounts
  alias Hello.Accounts.User
  alias Hello.Accounts.Guardian

  require Logger

  def index(conn, _p) do
    changeset = Accounts.change_user(%User{})
    maybe_user = Guardian.Plug.current_resource(conn)
    message = if maybe_user != nil do
      "Someone is logged in"
    else
      "No one is logged in"
    end
    Logger.debug(message)
    conn
    |> put_flash(:info, message)
    |> render("index.html", changeset: changeset, action: pm_path(conn, :login), maybe_user: maybe_user)
  end

  def login(conn, %{"user" => %{"account" => account, "passwd" => passwd}}) do
    Logger.debug("auth(#{account}, #{passwd})")
    Accounts.auth_user(account, passwd)
    |> login_reply(conn)
  end

  def logout(conn, _p) do
    conn
    |> Guardian.Plug.sign_out
    |> redirect(to: pm_path(conn, :login))
  end

  def secret(conn, _p) do
    render conn, "secret.html"
  end

  defp login_reply({:error, error}, conn) do
    conn
    |> put_flash(:error, error)
    |> redirect(to: "/pm")
  end
  defp login_reply({:ok, user}, conn) do
    conn
    |> put_flash(:success, "Welcom back!")
    |> Guardian.Plug.sign_in(user)
    |> redirect(to: "/pm")
  end
end