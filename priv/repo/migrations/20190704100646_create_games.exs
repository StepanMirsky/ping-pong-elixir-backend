defmodule PingPongElixir.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :home_user, :integer
      add :away_user, :integer
      add :winner, :integer
      add :home_approved, :boolean, default: false, null: false
      add :away_approved, :boolean, default: false, null: false
      add :home_score, :integer
      add :away_score, :integer

      timestamps()
    end

  end
end
