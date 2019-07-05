defmodule PingPongElixirWeb.UserController do
  use PingPongElixirWeb, :controller

  alias PingPongElixir.Auth
  alias PingPongElixir.Auth.User

  action_fallback PingPongElixirWeb.FallbackController

  def index(conn, _params) do
    users = Auth.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Auth.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render(PingPongElixirWeb.UserView, "user.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Auth.get_user!(id)
    conn
    |> render(PingPongElixirWeb.UserView, "user.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Auth.get_user!(id)

    with {:ok, %User{} = user} <- Auth.update_user(user, user_params) do
      conn
      |> render(PingPongElixirWeb.UserView, "user.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Auth.get_user!(id)

    with {:ok, %User{}} <- Auth.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def sign_in(conn, %{"login" => login, "password" => password}) do
    case PingPongElixir.Auth.authenticate_user(login, password) do
      {:ok, user} ->
        conn
        |> put_session(:current_user_id, user.id)
        |> put_status(:ok)
        |> render(PingPongElixirWeb.UserView, "user.json", user: user)

      {:error, message} ->
        conn
        |> delete_session(:current_user_id)
        |> put_status(:unauthorized)
        |> render(PingPongElixirWeb.ErrorView, "401.json", message: message)
    end
  end

  def registration(conn, attrs \\ %{}) do
    with {:ok, %User{} = user} <- Auth.create_user(attrs) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> put_session(:current_user_id, user.id)
      |> put_status(:ok)
      |> render(PingPongElixirWeb.UserView, "user.json", user: user)
    end
  end

  def get_current_user(conn, _params) do
    current_user_id = get_session(conn, :current_user_id)
    current_user = Auth.get_user!(current_user_id)

    current_user_games = Auth.list_user_games(current_user_id)

    conn
    |> render(PingPongElixirWeb.UserView, "current_user.json", user: current_user, games: current_user_games)
    # conn
    # |> render(PingPongElixirWeb.UserView, "user.json", user: current_user)
  end

  def approve(conn, %{"game_id" => game_id, "approved" => approved}) do
    current_user_id = get_session(conn, :current_user_id)
    game = Auth.get_game!(game_id)

    if game.home_user_id == current_user_id do
      Auth.update_game(game, %{"home_approved" => approved})
    else
      if game.away_user_id == current_user_id do
        Auth.update_game(game, %{"away_approved" => approved})
      end
    end

    conn
        |> put_status(:ok)
        |> render(PingPongElixirWeb.GameView, game: game)
  end

end
