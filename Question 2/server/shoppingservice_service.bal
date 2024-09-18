import ballerina/grpc;

listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: SHOPPING_DESC}
service "ShoppingService" on ep {

    remote function AddProduct(stream<Product, grpc:Error?> clientStream) returns ProductResponse|error {

        return error grpc:UnimplementedError("not suppported yet");

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

        return error grpc:UnimplementedError("not suppported yet");

    }

    remote function AddToCart(stream<CartRequest, grpc:Error?> clientStream) returns CartResponse|error {

        return error grpc:UnimplementedError("not suppported yet");

    }

    remote function PlaceOrder(stream<UserId, grpc:Error?> clientStream) returns OrderResponse|error {

        return error grpc:UnimplementedError("not suppported yet");

    }
}

