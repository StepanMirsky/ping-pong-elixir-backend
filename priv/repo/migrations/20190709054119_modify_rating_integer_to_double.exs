defmodule PingPongElixir.Repo.Migrations.ModifyRatingIntegerToDouble do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :rating, :float, default: 1000
    end
  end
end
