defmodule PingPongElixir.Repo.Migrations.ChangeRelatGamesUsers do
  use Ecto.Migration

  def change do
    alter table(:games) do
      add :away_user, references(:users), null: false
      add :home_user, references(:users), null: false
      add :winner, references(:users)
      remove :away_user_id, references(:users), null: false
      remove :home_user_id, references(:users), null: false
      remove :winner_id, references(:users)
    end

    alter table(:users) do
      add :winners, references(:games)
      add :home_users, references(:games)
      add :away_users, references(:games)
    end
  end
end
