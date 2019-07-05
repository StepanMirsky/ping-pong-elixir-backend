defmodule PingPongElixirWeb.GameController do
  use PingPongElixirWeb, :controller

  alias PingPongElixir.Auth
  alias PingPongElixir.Auth.Game

  action_fallback PingPongElixirWeb.FallbackController

  def index(conn, _params) do
    games = Auth.list_games()
    render(conn, "index.json", games: games)
  end

  def create(conn, %{"game" => game_params}) do
    with {:ok, %Game{} = game} <- Auth.create_game(game_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.game_path(conn, :show, game))
      |> render("show.json", game: game)
    end
  end

  def show(conn, %{"id" => id}) do
    game = Auth.get_game!(id)
    render(conn, "show.json", game: game)
  end

  def update(conn, %{"id" => id, "game" => game_params}) do
    game = Auth.get_game!(id)

    with {:ok, %Game{} = game} <- Auth.update_game(game, game_params) do
      render(conn, "show.json", game: game)
    end
  end

  def update_score(conn, %{"id" => id, "away_score" => away_score, "home_score" => home_score}) do
    game = Auth.get_game!(id)
    attrs = %{"away_score" => away_score, "home_score" => home_score, "is_finished" => :true}

    with {:ok, %Game{} = game} <- Auth.update_score(game, attrs) do
      render(conn, "show.json", game: game)
    end
  end

  def delete(conn, %{"id" => id}) do
    game = Auth.get_game!(id)

    with {:ok, %Game{}} <- Auth.delete_game(game) do
      send_resp(conn, :no_content, "")
    end
  end

  def create_game(conn, %{"away_user_name" => away_user_name}) do
    current_user_id = get_session(conn, :current_user_id)
    away_user = Auth.get_user_by_login(away_user_name)

    with {:ok, %Game{} = game} <- Auth.create_game(%{"away_user_id" => away_user.id, "home_user_id" => current_user_id}) do
      new_game = Auth.get_game!(game.id)
      render(conn, "show.json", game: new_game)
    end
  end
end
