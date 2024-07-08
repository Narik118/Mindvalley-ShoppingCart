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
    IO.inspect(cart_items)

    multi =
      Enum.reduce(cart_items, Ecto.Multi.new(), fn cart_item, multi ->
        product_id = cart_item["id"]
        quantity_change = cart_item["quantity"]

        check_operation = "check_#{product_id}" |> String.to_atom()
        update_operation = "update_#{product_id}" |> String.to_atom()

        multi
        |> Ecto.Multi.run(check_operation, fn _repo, _changes ->
          product = Repo.get!(InventorySchema, product_id)

          if product.quantity >= quantity_change do
            {:ok, product}
          else
            {:error, "Insufficient quantity for product ID #{product_id}"}
          end
        end)
        |> Ecto.Multi.update(update_operation, fn changes ->
          product = Map.get(changes, check_operation)
          Ecto.Changeset.change(product, quantity: product.quantity - quantity_change)
        end)
      end)

    case Repo.transaction(multi) do
      {:ok, _} ->
        {:ok, "Inventory quantities updated successfully"}

      {:error, _failed_operation, failed_value, _changes_so_far} ->
        {:error, failed_value}
    end
  end

end
