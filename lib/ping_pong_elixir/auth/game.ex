defmodule PingPongElixir.Auth.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :away_approved, :boolean, default: false
    field :away_score, :integer
    field :away_user, :integer
    field :home_approved, :boolean, default: false
    field :home_score, :integer
    field :home_user, :integer
    field :winner, :integer

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:home_user, :away_user, :winner, :home_approved, :away_approved, :home_score, :away_score])
    |> validate_required([:home_user, :away_user, :winner, :home_approved, :away_approved, :home_score, :away_score])
  end
end
