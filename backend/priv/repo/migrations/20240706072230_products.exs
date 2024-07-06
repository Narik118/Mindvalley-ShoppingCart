defmodule Backend.Repo.Migrations.Products do
  use Ecto.Migration

  def change do
    create table(:products, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :description, :text
      add :price, :decimal
      add :quantity, :integer
      add :product_image, :string
      add :length, :decimal
      add :width, :decimal
      add :height, :decimal
      add :rating, :decimal
      add :status, :string

      timestamps()
    end
  end
end
