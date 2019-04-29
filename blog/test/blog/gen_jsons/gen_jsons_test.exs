defmodule Blog.GenJsonsTest do
  use Blog.DataCase

  alias Blog.GenJsons

  describe "jsons" do
    alias Blog.GenJsons.Json

    @valid_attrs %{test: "some test"}
    @update_attrs %{test: "some updated test"}
    @invalid_attrs %{test: nil}

    def json_fixture(attrs \\ %{}) do
      {:ok, json} =
        attrs
        |> Enum.into(@valid_attrs)
        |> GenJsons.create_json()

      json
    end

    test "list_jsons/0 returns all jsons" do
      json = json_fixture()
      assert GenJsons.list_jsons() == [json]
    end

    test "get_json!/1 returns the json with given id" do
      json = json_fixture()
      assert GenJsons.get_json!(json.id) == json
    end

    test "create_json/1 with valid data creates a json" do
      assert {:ok, %Json{} = json} = GenJsons.create_json(@valid_attrs)
      assert json.test == "some test"
    end

    test "create_json/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GenJsons.create_json(@invalid_attrs)
    end

    test "update_json/2 with valid data updates the json" do
      json = json_fixture()
      assert {:ok, json} = GenJsons.update_json(json, @update_attrs)
      assert %Json{} = json
      assert json.test == "some updated test"
    end

    test "update_json/2 with invalid data returns error changeset" do
      json = json_fixture()
      assert {:error, %Ecto.Changeset{}} = GenJsons.update_json(json, @invalid_attrs)
      assert json == GenJsons.get_json!(json.id)
    end

    test "delete_json/1 deletes the json" do
      json = json_fixture()
      assert {:ok, %Json{}} = GenJsons.delete_json(json)
      assert_raise Ecto.NoResultsError, fn -> GenJsons.get_json!(json.id) end
    end

    test "change_json/1 returns a json changeset" do
      json = json_fixture()
      assert %Ecto.Changeset{} = GenJsons.change_json(json)
    end
  end
end
