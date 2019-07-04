defmodule PingPongElixirWeb.GameView do
  use PingPongElixirWeb, :view
  alias PingPongElixirWeb.GameView

  def render("index.json", %{games: games}) do
    %{data: render_many(games, GameView, "game.json")}
  end

  def render("show.json", %{game: game}) do
    %{data: render_one(game, GameView, "game.json")}
  end

  def render("game.json", %{game: game}) do
    %{id: game.id,
      home_user: game.home_user,
      away_user: game.away_user,
      winner: game.winner,
      home_approved: game.home_approved,
      away_approved: game.away_approved,
      home_score: game.home_score,
      away_score: game.away_score}
  end
end
