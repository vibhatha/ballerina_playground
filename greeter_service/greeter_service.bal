import ballerina/grpc;
import ballerina/protobuf.types.'any as pbAny;
listener grpc:Listener grpcListener = new (9090);

@grpc:Descriptor {value: HELLOWORLD_DESC}
service "Greeter" on grpcListener {
    remote function sayHello(HelloRequest value) returns HelloReply|error {
        
        map<anydata> personData = {
            "data": {
                "name": "John Doe",
                "age": 30,
                "email": "john.doe@example.com",
                "department": "Engineering",
                "salary": 75000.50
            }
        };

        pbAny:Any anyData = check pbAny:pack(personData);
        return {message: "Hello " + value.name, anyData: anyData};
    }
}