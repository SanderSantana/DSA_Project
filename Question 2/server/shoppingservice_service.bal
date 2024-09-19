import ballerina/grpc;

listener grpc:Listener ep = new (9090);

map<Product> products = {};
map<CartRequest[]> carts = {};
map<User> users = {};


@grpc:Descriptor {value: SHOPPING_DESC}
service "ShoppingService" on ep {

    remote function AddProduct(stream<Product, grpc:Error?> clientStream) returns ProductResponse|error {

        string addedProductCode = "";
        string addedDescription = "";

        // Iterate over the incoming stream of Products
        check from Product product in clientStream
            do {
                string productCode = product.sku;
                string description = product.description;

                // Store the product
                products[productCode] = product;

                addedProductCode = productCode;
                addedDescription = description;
            };

        // Return a response
        ProductResponse response = {
            product_code: addedProductCode,
            description: addedDescription
        };
        return response;


    }

    remote function CreateUsers(stream<User, grpc:Error?> clientStream) returns UserResponse|error {

    // Iterate over the incoming stream of Users
        check from User user in clientStream
            do {
                string userId = user.user_id;
                // Store the user
                users[userId] = user;
            };

        // Return a success response
        UserResponse response = {message: "Users created successfully"};
        return response;


    }

    remote function UpdateProduct(stream<Product, grpc:Error?> clientStream) returns ProductResponse|error {

        return error grpc:UnimplementedError("not suppported yet");

    }

    remote function RemoveProduct(stream<ProductId, grpc:Error?> clientStream) returns ProductList|error {

    Product[] removedProducts = [];

        // Iterate over the incoming stream of Product IDs
        check from ProductId productId in clientStream
            do {
                string productCode = productId.sku;

                // Check if the product exists in the map
                Product? product = products[productCode]; // This returns a Product? (optional type)

                if product is Product { // Check if the product is not nil
                    removedProducts.push(product);

                    // Correct the removal call. We don't need to assign the result of remove.
                    _ = products.remove(productCode); // Directly call remove here
                }
            };

        // Return the list of removed products
        ProductList response = {products: removedProducts};
        return response;


    }

    remote function ListAvailableProducts(stream<Empty, grpc:Error?> clientStream) returns ProductList|error {

        // Return the list of available products
        Product[] availableProducts = [];

        foreach var product in products {
            availableProducts.push(product);
        }

        ProductList response = {products: availableProducts};
        return response;

        // return error grpc:UnimplementedError("not suppported yet");

    }

    remote function SearchProduct(stream<ProductId, grpc:Error?> clientStream) returns Product|error {

      Product foundProduct = {};

    // Iterate over the incoming stream of Product IDs
    check from ProductId productId in clientStream
        do {
            string sku = productId.sku;

            // Search for the product by SKU
            Product? product = products[sku];

            if product is Product {
                foundProduct = product;
            } else {

                return error("Product with SKU " + sku + " not found");
            }
        }


    remote function AddToCart(stream<CartRequest, grpc:Error?> clientStream) returns CartResponse|error {

        return error grpc:UnimplementedError("not suppported yet");

    }

    remote function PlaceOrder(stream<UserId, grpc:Error?> clientStream) returns OrderResponse|error {

        string orderId = "";

        // Iterate over the incoming stream of User IDs
        check from UserId userId in clientStream
            do {
                string uid = userId.user_id;

                // Retrieve the user's cart and place an order
                CartRequest[]? cart = carts[uid]; // cart could be nil, so we need to check

                if cart is CartRequest[] { // Check if cart is not nil
                    // Process the order (e.g., assign order ID)
                    orderId = "ORDER-" + uid + "-" + (1 + cart.length()).toString();
                    _ = carts.remove(uid); // Clear the cart after placing the order
                } else {
                    return error("No items in cart for user " + uid);
                }
            };

        // Return the order response
        OrderResponse response = {
            order_id: orderId,
            message: "Order placed successfully"
        };
        return response;

    }
}

