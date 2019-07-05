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
    field :date_created, :utc_datetime_usec
    field :handicaped, :boolean
    field :is_finished, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:home_user, :away_user, :home_approved, :away_approved, :home_score, :away_score, :date_created, :handicaped, :is_finished])
    |> validate_required([:home_user, :away_user, :home_approved, :away_approved, :home_score, :away_score, :date_created, :handicaped, :is_finished])
  end

  def create_game_changeset(game, attrs) do
    game
    |> cast(attrs, [:away_user_id, :home_user_id])
    |> validate_required([:away_user_id, :home_user_id])
    |> put_change(:date_created, DateTime.utc_now())
    # |> cast_assoc([:away_user, :home_user])
  end
end
