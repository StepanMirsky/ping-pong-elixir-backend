defmodule PingPongElixir.Repo.Migrations.ChangeForeignKeyWinnerId do
  use Ecto.Migration

  def change do
    alter table(:games) do
      remove :winner, references(:users)
      add :winner, references(:users)
    end
  end
end
