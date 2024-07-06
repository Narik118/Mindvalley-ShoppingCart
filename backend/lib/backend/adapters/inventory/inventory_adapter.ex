defmodule Backend.Adapters.Inventory.InventoryAdapter do
  import Ecto.Query
  alias Backend.Repo
  alias Backend.Schemas.InventorySchema

  def get_inventory() do
    InventorySchema
    |> select([u], %{
      id: u.id,
      name: u.name,
      description: u.description,
      price: u.price,
      quantity: u.quantity,
      product_image: u.product_image,
      rating: u.rating,
      status: u.status
    })
    |> Repo.all()
  end

  def update_inventory_quantities(cart_items) do
    multi =
      Enum.reduce(cart_items, Ecto.Multi.new(), fn cart_item, multi ->
        product_id = cart_item["id"]
        quantity_change = cart_item["quantity"]

        changeset_fun = fn product ->
          Ecto.Changeset.change(product, quantity: product.quantity - quantity_change)
        end

        product = Repo.get!(InventorySchema, product_id)
        changeset = changeset_fun.(product)

        Ecto.Multi.update(multi, "update_#{product_id}", changeset)
      end)

    case Repo.transaction(multi) do
      {:ok, _} ->
        {:ok, "Inventory quantities updated successfully"}

      {:err_multi, _failed_operation, _failed_value, _changes_so_far} ->
        {:error, "Failed to update inventory quantities"}
    end
  end
end
