defmodule PingPongElixir.AuthTest do
  use PingPongElixir.DataCase

  alias PingPongElixir.Auth

  describe "users" do
    alias PingPongElixir.Auth.User

    @valid_attrs %{is_active: true, login: "some login"}
    @update_attrs %{is_active: false, login: "some updated login"}
    @invalid_attrs %{is_active: nil, login: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Auth.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Auth.list_users() == [%User{ user | password: nil}]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Auth.get_user!(user.id) == %User{user | password: nil}
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Auth.create_user(@valid_attrs)
      assert user.is_active == true
      assert user.login == "some login"
      assert Bcrypt.verify_pass("some password", user.password_hash)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auth.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Auth.update_user(user, @update_attrs)
      assert user.is_active == false
      assert user.login == "some updated login"
      assert Bcrypt.verify_pass("some updated password", user.password_hash)
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Auth.update_user(user, @invalid_attrs)
      assert %User{user | password: nil} == Auth.get_user!(user.id)
      assert Bcrypt.verify_pass("some password", user.password_hash)
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

  describe "games" do
    alias PingPongElixir.Auth.Game

    @valid_attrs %{away_approved: true, away_score: 42, away_user: 42, home_approved: true, home_score: 42, home_user: 42, winner: 42}
    @update_attrs %{away_approved: false, away_score: 43, away_user: 43, home_approved: false, home_score: 43, home_user: 43, winner: 43}
    @invalid_attrs %{away_approved: nil, away_score: nil, away_user: nil, home_approved: nil, home_score: nil, home_user: nil, winner: nil}

    def game_fixture(attrs \\ %{}) do
      {:ok, game} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Auth.create_game()

      game
    end

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert Auth.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert Auth.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      assert {:ok, %Game{} = game} = Auth.create_game(@valid_attrs)
      assert game.away_approved == true
      assert game.away_score == 42
      assert game.away_user == 42
      assert game.home_approved == true
      assert game.home_score == 42
      assert game.home_user == 42
      assert game.winner == 42
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auth.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()
      assert {:ok, %Game{} = game} = Auth.update_game(game, @update_attrs)
      assert game.away_approved == false
      assert game.away_score == 43
      assert game.away_user == 43
      assert game.home_approved == false
      assert game.home_score == 43
      assert game.home_user == 43
      assert game.winner == 43
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = Auth.update_game(game, @invalid_attrs)
      assert game == Auth.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = Auth.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Auth.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = Auth.change_game(game)
    end
  end
end
