defmodule PingPongElixirWeb.Router do
  use PingPongElixirWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :api_auth do
    plug :ensure_authenticated
  end

  scope "/api", PingPongElixirWeb do
    pipe_through :api
    post "/users/sign_in", UserController, :sign_in
    post "/users/registration", UserController, :registration
    resources "/games", GameController, except: [:new]
  end

  scope "/api", PingPongElixirWeb do
    pipe_through [:api, :api_auth]
    post "update_score", GameController, :update_score
    get "/users/me", UserController, :get_current_user
    resources "/users", UserController, except: [:new, :edit]
    post "/games/create", GameController, :create_game
  end

  defp ensure_authenticated(conn, _opts) do
    current_user_id = get_session(conn, :current_user_id)

    if current_user_id do
      conn
    else
      conn
      |> put_status(:unauthorized)
      |> render(PingPongElixirWeb.ErrorView, "401.json", message: "Unauthenticated user")
      |> halt
    end
  end
end
