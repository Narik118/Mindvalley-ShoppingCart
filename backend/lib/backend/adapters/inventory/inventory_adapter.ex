defmodule Backend.Adapters.Inventory.InventoryAdapter do
  import Ecto.Query
  require Logger
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

        case Repo.get(InventorySchema, product_id) do
          nil ->
            # Product not found, return an error tuple
            {:error, "Product not found with id #{product_id}"}

          product ->
            current_quantity = product.quantity

            if current_quantity < quantity_change do
              # If current quantity is less than quantity to deduct, return an error tuple
              {:error, {:inv, product_id}}
            else
              # Proceed with updating the quantity
              changeset =
                Ecto.Changeset.change(product, %{quantity: current_quantity - quantity_change})

              Ecto.Multi.update(multi, "update_#{product_id}", changeset)
            end
        end
      end)

    case multi do
      {:error, reason} ->
        {:error, reason}

      multi ->
        case Repo.transaction(multi) do
          {:ok, _} ->
            {:ok, "Inventory quantities updated successfully"}

          {:error, _} ->
            # Handle transaction error
            {:error, "Failed to update inventory quantities"}
        end
    end
  end

  # def update_inventory_quantities(cart_items) do
  #   IO.inspect(cart_items)
  #   multi =
  #     Enum.reduce(cart_items, Ecto.Multi.new(), fn cart_item, multi ->
  #       product_id = cart_item["id"]
  #       quantity_change = cart_item["quantity"]

  #       changeset_fun = fn product ->
  #         Ecto.Changeset.change(product, quantity: product.quantity - quantity_change)
  #       end

  #       product = Repo.get!(InventorySchema, product_id)
  #       changeset = changeset_fun.(product)

  #       Ecto.Multi.update(multi, "update_#{product_id}", changeset)
  #     end)

  #   case Repo.transaction(multi) do
  #     {:ok, _} ->
  #       {:ok, "Inventory quantities updated successfully"}

  #     {:err_multi, _failed_operation, _failed_value, _changes_so_far} ->
  #       {:error, "Failed to update inventory quantities"}
  #   end
  # end
end
