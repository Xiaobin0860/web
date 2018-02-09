defmodule Hello.AccountsTest do
  use Hello.DataCase

  alias Hello.Accounts

  describe "users" do
    alias Hello.Accounts.User

    @valid_attrs %{account: "some account", nick: "some nick", passwd: "some passwd"}
    @update_attrs %{account: "some updated account", nick: "some updated nick", passwd: "some updated passwd"}
    @invalid_attrs %{account: nil, nick: nil, passwd: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      u1 = user_fixture()
      [u2] = Accounts.list_users()
      assert u1.account == u2.account
      {:ok, user} = Accounts.auth_user(@valid_attrs.account, @valid_attrs.passwd)
      assert user.nick == u2.nick
      assert user.account == u2.account
      assert user.id == u1.id
    end

    test "get_user!/1 returns the user with given id" do
      u1 = user_fixture()
      u2 = Accounts.get_user!(u1.id)
      assert u1.account == u2.account
      {:ok, user} = Accounts.auth_user(@valid_attrs.account, @valid_attrs.passwd)
      assert user.nick == u2.nick
      assert user.account == u2.account
      assert user.id == u1.id
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.account == "some account"
      assert user.nick == "some nick"
      assert {:ok, _} = Accounts.auth_user(@valid_attrs.account, @valid_attrs.passwd)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.account == "some updated account"
      assert user.nick == "some updated nick"
      assert {:ok, _} = Accounts.auth_user(@update_attrs.account, @update_attrs.passwd)
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
