defmodule Takso.User do
  use Takso.Web, :model

  schema "users" do
    field :name, :string
    field :username, :string
    field :password, :string
    
    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :username, :password])
    |> validate_required([:name, :username, :password])
  end
end