import ballerina/io;
import ballerina/protobuf.types.'any as pbAny;

GreeterClient ep = check new ("http://localhost:9090");

type JsonObject map<anydata>;

public function main() returns error? {
    HelloReply sayHello = check ep->sayHello({name: "Ballerina"});
   
    io:println(`Response : ${sayHello.message}`);
    io:println(`Any Data Type URL: ${sayHello.anyData.typeUrl}`);
    io:println(`Any Data Value: ${sayHello.anyData.value}`);
    
    // Unpack the map from Any
    JsonObject personData = check pbAny:unpack(sayHello.anyData, JsonObject);
    
    io:println(`Person Data: ${personData["name"]}`);
    io:println(`Person Data: ${personData["age"]}`);
    io:println(`Person Data: ${personData["email"]}`);
    io:println(`Person Data: ${personData["department"]}`);
    io:println(`Person Data: ${personData["salary"]}`);
}