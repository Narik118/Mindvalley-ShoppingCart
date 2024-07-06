alias Backend.Repo
alias Backend.Schemas.InventorySchema

products = [
  %InventorySchema{name: "Product 1", description: "Description for Product 1", price: 10.0, quantity: 100, status: :avaiable},
  %InventorySchema{name: "Product 2", description: "Description for Product 2", price: 20.0, quantity: 200, status: :avaiable},
  %InventorySchema{name: "Product 3", description: "Description for Product 3", price: 30.0, quantity: 300, status: :out_of_stock}
]

for product <- products do
  Repo.insert!(product)
end
