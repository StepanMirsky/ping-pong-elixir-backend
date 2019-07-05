defmodule PingPongElixir.Repo.Migrations.ModifingGamesFields do
  use Ecto.Migration

  def change do
    alter table(:games) do
      modify :away_user, references(:users), null: false
      modify :home_user, references(:users), null: false
      modify :winner, references(:users)
      modify :home_score, :integer, default: 0
      modify :away_score, :integer, default: 0
      add :date_created, :utc_datetime, default: fragment("NOW()")
      add :handicaped, :boolean, null: false
    end

  end
end
