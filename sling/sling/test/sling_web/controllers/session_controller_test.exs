defmodule SlingWeb.SessionControllerTest do
  use SlingWeb.ConnCase
  require Logger
  alias Sling.Auth
  alias Sling.Auth.User

  @create_attrs %{email: "lxb@xl.com", nick: "some nick", pass: "some pass"}
  @invalid_attrs %{email: nil, nick: nil, pass: nil}
  @invalid_pass %{email: "lxb2@xl.com", nick: "some nick2", pass: "123"}
  @wrong_pass %{email: "lxb@xl.com", nick: "some nick", pass: "wrong pass"}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn} do
      conn = post conn, session_path(conn, :create), @create_attrs
      assert %{"email" => email, "nick" => nick} = json_response(conn, 200)["data"]
      assert email == @create_attrs.email
      assert nick == @create_attrs.nick
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, session_path(conn, :create), @invalid_attrs
      assert json_response(conn, 401)["error"] != %{}
    end

    test "renders errors when pass is invalid", %{conn: conn} do
      conn = post conn, session_path(conn, :create), @invalid_pass
      assert json_response(conn, 401)["error"] != %{}
    end

    test "renders errors when pass is wrong", %{conn: conn} do
      conn = post conn, session_path(conn, :create), @wrong_pass
      assert json_response(conn, 401)["error"] != %{}
    end
  end

  defp create_user(_) do
    {:ok, user} = Auth.create_user(@create_attrs)
    {:ok, user: user}
  end
end
