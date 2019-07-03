defmodule PingPongElixirWeb.Router do
  use PingPongElixirWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PingPongElixirWeb do
    pipe_through :api
  end
end
