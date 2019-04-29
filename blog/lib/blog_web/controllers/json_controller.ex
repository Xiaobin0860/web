defmodule BlogWeb.JsonController do
  use BlogWeb, :controller

  alias Blog.GenJsons
  alias Blog.GenJsons.Json

  action_fallback BlogWeb.FallbackController

  def index(conn, _params) do
    jsons = GenJsons.list_jsons()
    render(conn, "index.json", jsons: jsons)
  end

  def create(conn, %{"json" => json_params}) do
    with {:ok, %Json{} = json} <- GenJsons.create_json(json_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", json_path(conn, :show, json))
      |> render("show.json", json: json)
    end
  end

  def show(conn, %{"id" => id}) do
    json = GenJsons.get_json!(id)
    render(conn, "show.json", json: json)
  end

  def update(conn, %{"id" => id, "json" => json_params}) do
    json = GenJsons.get_json!(id)

    with {:ok, %Json{} = json} <- GenJsons.update_json(json, json_params) do
      render(conn, "show.json", json: json)
    end
  end

  def delete(conn, %{"id" => id}) do
    json = GenJsons.get_json!(id)
    with {:ok, %Json{}} <- GenJsons.delete_json(json) do
      send_resp(conn, :no_content, "")
    end
  end
end
