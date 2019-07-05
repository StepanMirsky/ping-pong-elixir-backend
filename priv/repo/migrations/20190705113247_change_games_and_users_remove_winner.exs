defmodule PingPongElixir.Repo.Migrations.ChangeGamesAndUsersRemoveWinner do
  use Ecto.Migration

  def change do
    alter table(:games) do
      remove :winner_id, references(:users)
      add :is_finished, :boolean, default: false, null: false
    end

    alter table(:users) do
      add :winners, references(:games)
    end
  end
end
