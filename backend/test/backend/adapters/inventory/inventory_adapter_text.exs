# test/backend/adapters/inventory/inventory_adapter_test.exs
defmodule Backend.Adapters.Inventory.InventoryAdapterTest do
  use ExUnit.Case, async: true
  use Backend.DataCase  # Assuming you have a DataCase setup for database tests

  alias Backend.Adapters.Inventory.InventoryAdapter
  alias Backend.Schemas.InventorySchema

  @valid_attrs %{name: "Product 1", description: "A product", price: 100, quantity: 10, product_image: "image.jpg", rating: 5, status: "available"}
  @valid_attrs2 %{name: "Product 2", description: "Another product", price: 200, quantity: 20, product_image: "image2.jpg", rating: 4, status: "available"}

  setup do
    product1 = %InventorySchema{}
    |> InventorySchema.changeset(@valid_attrs)
    |> Repo.insert!()

    product2 = %InventorySchema{}
    |> InventorySchema.changeset(@valid_attrs2)
    |> Repo.insert!()

    {:ok, product1: product1, product2: product2}
  end

  describe "get_inventory/0" do
    test "returns all products in inventory" do
      products = InventoryAdapter.get_inventory()

      assert length(products) == 2
      assert Enum.any?(products, fn p -> p.name == "Product 1" end)
      assert Enum.any?(products, fn p -> p.name == "Product 2" end)
    end
  end

  describe "update_inventory_quantities/1" do
    test "successfully updates inventory quantities", %{product1: product1, product2: product2} do
      cart_items = [%{"id" => product1.id, "quantity" => 2}, %{"id" => product2.id, "quantity" => 5}]

      assert {:ok, "Inventory quantities updated successfully"} = InventoryAdapter.update_inventory_quantities(cart_items)

      updated_product1 = Repo.get!(InventorySchema, product1.id)
      updated_product2 = Repo.get!(InventorySchema, product2.id)

      assert updated_product1.quantity == @valid_attrs[:quantity] - 2
      assert updated_product2.quantity == @valid_attrs2[:quantity] - 5
    end

    test "returns error when quantity is insufficient", %{product1: product1, product2: product2} do
      cart_items = [%{"id" => product1.id, "quantity" => 15}, %{"id" => product2.id, "quantity" => 25}]

      assert {:error, _reason} = InventoryAdapter.update_inventory_quantities(cart_items)

      updated_product1 = Repo.get!(InventorySchema, product1.id)
      updated_product2 = Repo.get!(InventorySchema, product2.id)

      assert updated_product1.quantity == @valid_attrs[:quantity]
      assert updated_product2.quantity == @valid_attrs2[:quantity]
    end
  end
end
