defmodule PingPongElixir.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :login, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :photo, :string
    field :rating, :integer

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

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes:
    %{password: password}} = changeset) do
      change(changeset, Bcrypt.add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
