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

        return error grpc:UnimplementedError("not suppported yet");

    }

    remote function UpdateProduct(stream<Product, grpc:Error?> clientStream) returns ProductResponse|error {

        return error grpc:UnimplementedError("not suppported yet");

    }

    remote function RemoveProduct(stream<ProductId, grpc:Error?> clientStream) returns ProductList|error {

        return error grpc:UnimplementedError("not suppported yet");

    }

    remote function ListAvailableProducts(stream<Empty, grpc:Error?> clientStream) returns ProductList|error {

        return error grpc:UnimplementedError("not suppported yet");

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


    remote function AddToCart(stream<CartRequest, grpc:Error?> clientStream) returns CartResponse|error {

        return error grpc:UnimplementedError("not suppported yet");

    }

    remote function PlaceOrder(stream<UserId, grpc:Error?> clientStream) returns OrderResponse|error {

        return error grpc:UnimplementedError("not suppported yet");

    }
}

