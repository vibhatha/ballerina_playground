import ballerina/grpc;
import ballerina/protobuf.types.'any as pbAny;
listener grpc:Listener grpcListener = new (9090);

@grpc:Descriptor {value: HELLOWORLD_DESC}
service "Greeter" on grpcListener {
    remote function sayHello(HelloRequest value) returns HelloReply|error {

        json jsonData = {
            "name": "John Doe",
            "age": 30,
            "email": "john.doe@example.com"
        };

        pbAny:Any anyData = check pbAny:pack(jsonData.toJsonString());
        
        return {message: "Hello " + value.name, anyData: anyData};
    }
}