import ballerina/io;
import ballerina/protobuf.types.'any as pbAny;

GreeterClient ep = check new ("http://localhost:9090");

public function main() returns error? {

    HelloReply sayHello = check ep->sayHello({name: "Ballerina"});
   
    io:println(`Response : ${sayHello.message}`);
    io:println(`Any Data : ${sayHello.anyData}`);

    // Unpack as string and parse the JSON string
    string stringResult = check pbAny:unpack(sayHello.anyData, string);
    if stringResult is string {
        // Then parse the JSON string
        io:println(`JSON Data : ${stringResult}`);
    }

}