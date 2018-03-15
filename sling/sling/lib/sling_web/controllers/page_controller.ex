defmodule SlingWeb.PageController do
  use SlingWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
