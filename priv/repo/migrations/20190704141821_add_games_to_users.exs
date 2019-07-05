defmodule PingPongElixir.Repo.Migrations.AddGamesToUsers do
  use Ecto.Migration

  def change do
    alter table(:games) do
      remove :away_user, references(:users), null: false
      remove :home_user, references(:users), null: false
      remove :winner, references(:users)
      add :away_user_id, references(:users), null: false
      add :home_user_id, references(:users), null: false
      add :winner_id, references(:users)
    end
  end
end
