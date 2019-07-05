defmodule PingPongElixir.Repo.Migrations.ChangeForeignKeyNames do
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

    alter table(:users) do
      remove :winners, references(:games)
      remove :home_users, references(:games)
      remove :away_users, references(:games)
      add :away_user_id, references(:games)
      add :home_user_id, references(:games)
      add :winner_id, references(:games)
    end
  end
end
