defmodule BlogWeb.JsonControllerTest do
  use BlogWeb.ConnCase

  alias Blog.GenJsons
  alias Blog.GenJsons.Json

  @create_attrs %{test: "some test"}
  @update_attrs %{test: "some updated test"}
  @invalid_attrs %{test: nil}

  def fixture(:json) do
    {:ok, json} = GenJsons.create_json(@create_attrs)
    json
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all jsons", %{conn: conn} do
      conn = get conn, json_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create json" do
    test "renders json when data is valid", %{conn: conn} do
      conn = post conn, json_path(conn, :create), json: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, json_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "test" => "some test"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, json_path(conn, :create), json: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update json" do
    setup [:create_json]

    test "renders json when data is valid", %{conn: conn, json: %Json{id: id} = json} do
      conn = put conn, json_path(conn, :update, json), json: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, json_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "test" => "some updated test"}
    end

    test "renders errors when data is invalid", %{conn: conn, json: json} do
      conn = put conn, json_path(conn, :update, json), json: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete json" do
    setup [:create_json]

    test "deletes chosen json", %{conn: conn, json: json} do
      conn = delete conn, json_path(conn, :delete, json)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, json_path(conn, :show, json)
      end
    end
  end

  defp create_json(_) do
    json = fixture(:json)
    {:ok, json: json}
  end
end
