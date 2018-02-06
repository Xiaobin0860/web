defmodule HelloWeb.HelloController do
  use HelloWeb, :controller

  def index(conn, _p) do
    render(conn, "index.html")
  end

  def hello(conn, %{"messager" => messager}) do
    render(conn, "hello.html", messager: messager)
  end
end
