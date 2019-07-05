defmodule PingPongElixir.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :login, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :photo, :string
    field :rating, :integer, default: 1000
    has_many :home_users, PingPongElixir.Auth.Game, foreign_key: :home_user_id
    has_many :away_users, PingPongElixir.Auth.Game, foreign_key: :away_user_id

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:login, :password])
    |> validate_required([:login, :password])
    |> unique_constraint(:login)
    |> put_pass_hash()
  end

  def update_rating(user, attrs) do
    user
    |> cast(attrs, [:rating])
    |> validate_required([:rating])
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes:
    %{password: password}} = changeset) do
      change(changeset, Bcrypt.add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
