defmodule PingPongElixir.Repo.Migrations.ChangingUserFields do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :photo, :string
      add :rating, :integer
      remove :is_active
    end
  end
end
