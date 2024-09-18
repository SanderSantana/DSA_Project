import ballerina/io;

ShoppingServiceClient ep = check new ("http://localhost:9090");

public function main() returns error? {
    Product addProductRequest = {name: "ballerina", description: "ballerina", price: 1, stock_quantity: 1, sku: "ballerina", status: "ballerina"};
    AddProductStreamingClient addProductStreamingClient = check ep->AddProduct();
    check addProductStreamingClient->sendProduct(addProductRequest);
    check addProductStreamingClient->complete();
    ProductResponse? addProductResponse = check addProductStreamingClient->receiveProductResponse();
    io:println(addProductResponse);

    User createUsersRequest = {user_id: "ballerina", name: "ballerina", role: "ballerina"};
    CreateUsersStreamingClient createUsersStreamingClient = check ep->CreateUsers();
    check createUsersStreamingClient->sendUser(createUsersRequest);
    check createUsersStreamingClient->complete();
    UserResponse? createUsersResponse = check createUsersStreamingClient->receiveUserResponse();
    io:println(createUsersResponse);

    Product updateProductRequest = {name: "ballerina", description: "ballerina", price: 1, stock_quantity: 1, sku: "ballerina", status: "ballerina"};
    UpdateProductStreamingClient updateProductStreamingClient = check ep->UpdateProduct();
    check updateProductStreamingClient->sendProduct(updateProductRequest);
    check updateProductStreamingClient->complete();
    ProductResponse? updateProductResponse = check updateProductStreamingClient->receiveProductResponse();
    io:println(updateProductResponse);

    ProductId removeProductRequest = {sku: "ballerina"};
    RemoveProductStreamingClient removeProductStreamingClient = check ep->RemoveProduct();
    check removeProductStreamingClient->sendProductId(removeProductRequest);
    check removeProductStreamingClient->complete();
    ProductList? removeProductResponse = check removeProductStreamingClient->receiveProductList();
    io:println(removeProductResponse);

    Empty listAvailableProductsRequest = {};
    ListAvailableProductsStreamingClient listAvailableProductsStreamingClient = check ep->ListAvailableProducts();
    check listAvailableProductsStreamingClient->sendEmpty(listAvailableProductsRequest);
    check listAvailableProductsStreamingClient->complete();
    ProductList? listAvailableProductsResponse = check listAvailableProductsStreamingClient->receiveProductList();
    io:println(listAvailableProductsResponse);

    ProductId searchProductRequest = {sku: "ballerina"};
    SearchProductStreamingClient searchProductStreamingClient = check ep->SearchProduct();
    check searchProductStreamingClient->sendProductId(searchProductRequest);
    check searchProductStreamingClient->complete();
    Product? searchProductResponse = check searchProductStreamingClient->receiveProduct();
    io:println(searchProductResponse);

    CartRequest addToCartRequest = {user_id: "ballerina", sku: "ballerina"};
    AddToCartStreamingClient addToCartStreamingClient = check ep->AddToCart();
    check addToCartStreamingClient->sendCartRequest(addToCartRequest);
    check addToCartStreamingClient->complete();
    CartResponse? addToCartResponse = check addToCartStreamingClient->receiveCartResponse();
    io:println(addToCartResponse);

    UserId placeOrderRequest = {user_id: "ballerina"};
    PlaceOrderStreamingClient placeOrderStreamingClient = check ep->PlaceOrder();
    check placeOrderStreamingClient->sendUserId(placeOrderRequest);
    check placeOrderStreamingClient->complete();
    OrderResponse? placeOrderResponse = check placeOrderStreamingClient->receiveOrderResponse();
    io:println(placeOrderResponse);
}

