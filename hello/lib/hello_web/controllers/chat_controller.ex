defmodule HelloWeb.ChatController do
  use HelloWeb, :controller

  def index(conn, _p) do
    render conn, "index.html"
  end
end