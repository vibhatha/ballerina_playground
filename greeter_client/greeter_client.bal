import ballerina/io;
import ballerina/protobuf.types.'any as pbAny;

GreeterClient ep = check new ("http://localhost:9090");

// Define the types to match your server structure
type JsonObject map<anydata>;
type DataWrapper record {|
    JsonObject data;
|};



public function main() returns error? {
    HelloReply sayHello = check ep->sayHello({name: "Ballerina"});
    
    io:println(`Response : ${sayHello.message}`);
    io:println(`Any Data Type URL: ${sayHello.anyData.typeUrl}`);
    io:println(`Any Data Value: ${sayHello.anyData.value}`);
    // Unpack the map from Any
    // Unpack the outer map (which contains the "data" field)
    // Unpack as map<anydata> (same type as what was packed)
    map<anydata> outerData = check pbAny:unpack(sayHello.anyData);
    io:println(`Outer Data: ${outerData}`);
}