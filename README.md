## Overview
This repository contains two implementations:
1. A **RESTful API** for managing program development workflows at the Namibia University of Science and Technology.
2. An **Online Shopping System** using gRPC that allows customers and admins to interact with the system for product management.

## Restful API for Program Development

### Features
- **Add a new programme**: Create a new programme with essential attributes.
- **Retrieve all programmes**: Get a list of all programmes within the Programme Development Unit.
- **Update a programme**: Modify existing programme information using the programme code.
- **Retrieve a specific programme**: Get details of a programme by its programme code.
- **Delete a programme**: Remove a programme record by its programme code.
- **Retrieve programmes due for review**: List all programmes that need to be reviewed.
- **Retrieve programmes by faculty**: Get all programmes belonging to a specific faculty.

## Online Shopping System using gRPC

### Features
- **Add product**: Admin creates a new product with fields like name, description, price, and stock quantity.
- **Update product**: Admin updates product details.
- **Remove product**: Admin removes a product from inventory.
- **List available products**: Customers get a list of all available products.
- **Search product**: Customers can search for a product by its SKU.
- **Add to cart**: Customers add products to their cart.
- **Place order**: Customers place an order for products in their cart.
