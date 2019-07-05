defmodule PingPongElixir.Repo.Migrations.ChangeGamesCreatedDateType do
  use Ecto.Migration

  def change do
    alter table(:games) do
      modify :handicaped, :boolean, null: true
    end
  end
end
