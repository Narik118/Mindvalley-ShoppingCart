defmodule BackendWeb.Inventory.InventoryController do
  use BackendWeb, :controller

  alias Backend.Adapters.Inventory.InventoryAdapter

  def get_inventory(conn, _params) do
    case InventoryAdapter.get_inventory() do
      [] ->
        resp = %{message: "Inventory Empty !"}

        conn
        |> put_status(201)
        |> json(resp)

      products ->
        resp = %{inventory: products}

        conn
        |> put_status(200)
        |> json(resp)

      _ ->
        resp = %{error: "Failed to get inventory"}

        conn
        |> put_status(400)
        |> json(resp)
    end
  end

  def update_inventory(conn, _params) do
    cart_items = conn.params["_json"]

    with :ok <- validate_cart_items(cart_items),
         {:ok, _} <- InventoryAdapter.update_inventory_quantities(cart_items) do
      resp = %{error: "Inventory Updated Sucessfully"}

      conn
      |> put_status(:bad_request)
      |> json(resp)
    else
      {:error, error_message} ->
        resp = %{error: error_message}

        conn
        |> put_status(:bad_request)
        |> json(resp)

      {:err_multi, _failed_operation, _failed_value, _changes_so_far} ->
        resp = %{error: "Updating Inventory Failed"}

        conn
        |> put_status(:bad_request)
        |> json(resp)
    end
  end

  # validations for the payload - can be extended using a struct to validate
  defp validate_cart_items(nil), do: {:error, "Payload missing"}

  defp validate_cart_items(cart_items) when is_list(cart_items) do
    if Enum.all?(cart_items, &valid_item?/1) do
      :ok
    else
      {:error, "Each item must contain only id, name, and quantity"}
    end
  end

  defp validate_cart_items(_), do: {:error, "Invalid payload format"}

  defp valid_item?(%{"id" => _, "name" => _, "quantity" => _} = item) do
    Map.keys(item) == ["id", "name", "quantity"]
  end

  defp valid_item?(_), do: false
end
