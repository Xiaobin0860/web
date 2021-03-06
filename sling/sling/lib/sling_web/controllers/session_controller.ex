defmodule SlingWeb.SessionController do
  use SlingWeb, :controller
  alias Sling.Auth
  alias Sling.Auth.Guardian
  require Logger

  def create(conn, %{"email" => email, "pass" => pass}) do
    Logger.debug("email=#{email}, pass=#{pass}")
    case Auth.auth_user(email, pass) do
      {:ok, user} ->
        new_conn = Guardian.Plug.sign_in(conn, user)
        jwt = Guardian.Plug.current_token(new_conn)
        Logger.debug("jwt=#{jwt}, user=#{inspect user}")
        new_conn
        # |> put_status(:created)
        |> render("show.json", user: user, jwt: jwt)
      {:error, _reason} ->
        conn
        |> put_status(:unauthorized)
        |> render("error.json")
    end
  end

  def delete(conn, _) do
    jwt = Guardian.Plug.current_token(conn)
    Guardian.revoke(jwt)

    conn
    |> put_status(:ok)
    |> render("delete.json")
  end

  def refresh(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    jwt = Guardian.Plug.current_token(conn)
    case Guardian.refresh(jwt) do
      {:ok, _old_stuff, {new_jwt, _new_claims}} ->
        conn
        |> put_status(:ok)
        |> render("show.json", user: user, jwt: new_jwt)
      {:error, _reason} ->
        conn
        |> put_status(:unauthorized)
        |> render("forbidden.json", error: "Not authenticated")
    end
  end

  def unauthenticated(conn, _params) do
    conn
    |> put_status(:forbidden)
    |> render(Sling.SessionView, "forbidden.json", error: "Not Authenticated")
  end
end