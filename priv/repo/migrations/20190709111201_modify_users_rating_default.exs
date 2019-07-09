defmodule PingPongElixir.Repo.Migrations.ModifyUsersRatingDefault do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :rating, :float, default: 1000.0
    end
  end
end
