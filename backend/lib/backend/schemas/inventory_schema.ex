defmodule Backend.Schemas.InventorySchema do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "products" do
    field :name, :string
    field :description, :string
    field :price, :decimal
    field :quantity, :integer
    field :product_image, :string
    field :length, :decimal
    field :width, :decimal
    field :height, :decimal
    field :rating, :decimal
    field :status, Ecto.Enum, values: [:out_of_stock, :available]

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [
      :name,
      :description,
      :price,
      :quantity,
      :length,
      :width,
      :height,
      :product_image,
      :rating,
      :status
    ])
    |> validate_required([:name, :description, :price, :quantity, :status])
  end
end
