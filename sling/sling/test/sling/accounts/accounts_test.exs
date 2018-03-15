defmodule Sling.AccountsTest do
  use Sling.DataCase

  alias Sling.Accounts

  describe "players" do
    alias Sling.Accounts.Player

    @valid_attrs %{account: "some account", nick: "some nick", pass: "some pass"}
    @update_attrs %{account: "some updated account", nick: "some updated nick", pass: "some updated pass"}
    @invalid_attrs %{account: nil, nick: nil, pass: nil}

    def player_fixture(attrs \\ %{}) do
      {:ok, player} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_player()

      player
    end

    test "list_players/0 returns all players" do
      player = player_fixture()
      [p2] = Accounts.list_players()
      assert player.nick == p2.nick
      assert player.account == p2.account
      assert player.pass == p2.pass
    end

    test "get_player!/1 returns the player with given id" do
      player = player_fixture()
      p2 = Accounts.get_player!(player.id)
      assert player.nick == p2.nick
      assert player.account == p2.account
      assert player.pass == p2.pass
    end

    test "create_player/1 with valid data creates a player" do
      assert {:ok, %Player{} = player} = Accounts.create_player(@valid_attrs)
      assert player.account == "some account"
      assert player.nick == "some nick"
      assert player.pass == "some pass"
    end

    test "create_player/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_player(@invalid_attrs)
    end

    test "update_player/2 with valid data updates the player" do
      player = player_fixture()
      assert {:ok, player} = Accounts.update_player(player, @update_attrs)
      assert %Player{} = player
      assert player.account == "some updated account"
      assert player.nick == "some updated nick"
      assert player.pass == "some updated pass"
    end

    test "update_player/2 with invalid data returns error changeset" do
      player = player_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_player(player, @invalid_attrs)
      p2 = Accounts.get_player!(player.id)
      assert player.nick == p2.nick
      assert player.account == p2.account
      assert player.pass == p2.pass
    end

    test "delete_player/1 deletes the player" do
      player = player_fixture()
      assert {:ok, %Player{}} = Accounts.delete_player(player)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_player!(player.id) end
    end

    test "change_player/1 returns a player changeset" do
      player = player_fixture()
      assert %Ecto.Changeset{} = Accounts.change_player(player)
    end
  end
end
