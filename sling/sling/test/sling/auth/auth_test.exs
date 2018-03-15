defmodule Sling.AuthTest do
  use Sling.DataCase

  alias Sling.Auth

  describe "users" do
    alias Sling.Auth.User

    @valid_attrs %{email: "some email", nick: "some nick", pass: "some pass"}
    @update_attrs %{email: "some updated email", nick: "some updated nick", pass: "some updated pass"}
    @invalid_attrs %{email: nil, nick: nil, pass: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Auth.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      [u2] = Auth.list_users()
      assert user.nick == u2.nick
      assert user.email == u2.email
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      u2 = Auth.get_user!(user.id)
      assert user.nick == u2.nick
      assert user.email == u2.email
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Auth.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.nick == "some nick"
      assert {:ok, _} = Auth.auth_user(user.email, @valid_attrs.pass)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auth.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Auth.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.nick == "some updated nick"
      assert {:ok, _} = Auth.auth_user(user.email, "some updated pass")
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Auth.update_user(user, @invalid_attrs)
      u2 = Auth.get_user!(user.id)
      assert user.nick == u2.nick
      assert user.email == u2.email
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Auth.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Auth.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Auth.change_user(user)
    end
  end
end
