defmodule PingPongElixir.Repo do
  use Ecto.Repo,
    otp_app: :ping_pong_elixir,
    adapter: Ecto.Adapters.Postgres
end
