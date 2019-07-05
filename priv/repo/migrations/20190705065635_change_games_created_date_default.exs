defmodule PingPongElixir.Repo.Migrations.ChangeGamesCreatedDateDefault do
  use Ecto.Migration

  def change do
    alter table(:games) do
      modify :date_created, null: false
    end
  end
end
