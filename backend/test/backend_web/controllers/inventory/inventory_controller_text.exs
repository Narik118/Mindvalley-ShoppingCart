defmodule BackendWeb.Inventory.InventoryControllerTest do
  use BackendWeb.ConnCase
  alias Backend.Schemas.InventorySchema
  alias Backend.Repo

  @valid_attrs %{name: "Product 1", description: "Description", price: 100, quantity: 10, product_image: "image.png", rating: 5, status: "available"}
  @valid_attrs2 %{name: "Product 2", description: "Description", price: 200, quantity: 20, product_image: "image2.png", rating: 4, status: "available"}

  setup do
    product1 = insert_product(@valid_attrs)
    product2 = insert_product(@valid_attrs2)

    # Build a connection for testing
    conn = build_conn()

    {:ok, conn: conn, product1: product1, product2: product2}
  end

  defp insert_product(attrs) do
    %InventorySchema{}
    |> InventorySchema.changeset(attrs)
    |> Repo.insert!()
  end

  describe "get_inventory/2" do

    test "returns inventory when products are available", %{conn: conn} do
      conn = get(conn, "/api/v1/inventory")

      assert json_response(conn, 200)["inventory"] != []
    end

    test "returns empty message when inventory is empty", %{conn: conn} do
      Repo.delete_all(InventorySchema)

      conn = get(conn, "/api/v1/inventory")

      assert json_response(conn, 201) == %{"message" => "Inventory Empty !"}
    end

    # test "returns error message on failure", %{conn: conn} do
    #   # Modify the test to simulate a failure scenario by clearing the database
    #   Repo.delete_all(InventorySchema)

    #   conn = get(conn, "/api/v1/inventory")

    #   assert json_response(conn, 400)["error"] == "Failed to get inventory"
    # end

  # describe "update_inventory/2" do
    test "successfully updates inventory", %{conn: conn, product1: product1, product2: product2} do
      cart_items = [
        %{"id" => product1.id, "price" => product1.price, "quantity" => 2},
        %{"id" => product2.id, "price" => product2.price, "quantity" => 5}
      ]

      body = Jason.encode!(%{_json: cart_items})

      conn =
        conn
        |> put_req_header("content-type", "application/json")
        |> put("/api/v1/checkout", body)

      assert conn.status == 200
      assert json_response(conn, 200)["message"] == "Inventory Updated Successfully"

      updated_product1 = Repo.get!(InventorySchema, product1.id)
      updated_product2 = Repo.get!(InventorySchema, product2.id)

      assert updated_product1.quantity == @valid_attrs[:quantity] - 2
      assert updated_product2.quantity == @valid_attrs2[:quantity] - 5
    end

    test "returns error when product is out of stock", %{conn: conn, product1: product1, product2: product2} do
      cart_items = [
        %{"id" => product1.id, "price" => product1.price, "quantity" => 100},  # Quantity greater than available
        %{"id" => product2.id, "price" => product2.price, "quantity" => 5}
      ]

      conn =
        conn
        |> put_req_header("content-type", "application/json")
        |> put(
          "/api/v1/checkout",
          Jason.encode!(%{_json: cart_items})
        )

      assert conn.status == 400

      # Adjust the assertion to check for the specific error message format returned
      assert String.contains?(json_response(conn, 400)["error"], "Insufficient quantity for product ID #{product1.id}")
    end

    test "returns error when payload is missing", %{conn: conn} do
      conn =
        conn
        |> put_req_header("content-type", "application/json")
        |> put(
          "/api/v1/checkout",
          nil  # Missing payload
        )

      assert conn.status == 400
      assert json_response(conn, 400)["error"] == "Payload missing"
    end

  end
end
