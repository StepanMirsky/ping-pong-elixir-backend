defmodule PingPongElixirWeb.GameView do
  use PingPongElixirWeb, :view
  alias PingPongElixirWeb.GameView
  alias PingPongElixirWeb.UserView

  def render("index.json", %{games: games}) do
    render_many(games, GameView, "game.json")
  end

  def render("show.json", %{game: game}) do
    render_one(game, GameView, "game.json")
  end

  def render("game.json", %{game: game}) do
    %{id: game.id,
      home_user: render_one(game.home_user, UserView, "user.json"),
      away_user: render_one(game.away_user, UserView, "user.json"),
      home_approved: game.home_approved,
      away_approved: game.away_approved,
      home_score: game.home_score,
      away_score: game.away_score,
      date_created: game.date_created,
      is_finished: game.is_finished}
  end
end
