defmodule PingPongElixir.Repo.Migrations.ModifingUserFieldsRating do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :rating, :integer, default: 1000
    end
  end
end
