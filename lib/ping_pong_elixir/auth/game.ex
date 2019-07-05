defmodule PingPongElixir.Auth.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :away_approved, :boolean, default: false
    field :away_score, :integer, default: 0
    belongs_to :away_user, PingPongElixir.Auth.User, foreign_key: :away_user_id
    field :home_approved, :boolean, default: false
    field :home_score, :integer, default: 0
    belongs_to :home_user, PingPongElixir.Auth.User, foreign_key: :home_user_id
    belongs_to :winner, PingPongElixir.Auth.User, foreign_key: :winner_id
    field :date_created, :utc_datetime, default: :utc_datetime
    field :handicaped, :boolean

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:home_user, :away_user, :winner, :home_approved, :away_approved, :home_score, :away_score, :date_created, :handicaped])
    |> validate_required([:home_user, :away_user, :winner, :home_approved, :away_approved, :home_score, :away_score, :date_created, :handicaped])
  end
end
