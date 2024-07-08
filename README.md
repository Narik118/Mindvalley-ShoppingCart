# Mindvalley-ShoppingCart

## Running the application
Once you have the Shopping Cart folder with you
### Inside backend folder

cd into the backend folder and execute 
- mix deps.get
- mix ecto.setup
- mix ecto.reset
- mix priv/repo/inventory_seeds.exs
- mix phx.server

### Inside frontend folder

cd into the frontend folder and execute
- npm run serve 

# Design
## Frontend

* We are using vuex to manage the state aof prodcuts and the cart
* We have 2 components NavigationCompontnt.vue and the ProductCard.vue 
* We have view component ProductList.vue which uses these two compoenents to display the list of products and the cart
* I would have used another compoenent for the cart but time did not permit !!
* We are using tailwind to style our compoennets
* There is also a toast to indicate weather the checkout was successfull or not (could have been a seperate component !)

## features
* We can view products
* We can add products in cart
* We can increase and decrese quantity of products in cart
* We can checkoout from the cart 

# Backend

We have 2 api routes 
- "/api/v1/inventory" : gets all the products from the inventory
- "/api/v1/checkout" : checks out the prodcuts in our case decrements the quantity in the database

We have InventoryController module in place to hanlde the logic realted to both the routes 
We are using InventoryAdapter to wrap the ecto queries to inventory database
We have also defined the inventory database schema and migration
