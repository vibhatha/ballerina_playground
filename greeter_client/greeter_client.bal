import ballerina/io;
import ballerina/protobuf.types.'any as pbAny;

GreeterClient ep = check new ("http://localhost:9090");

public function main() returns error? {
    HelloReply sayHello = check ep->sayHello({name: "Ballerina"});
   
   io:println(`Response : ${sayHello.message}`);
   io:println(`Any Data : ${sayHello.anyData}`);

   pbAny:Any anyData = sayHello.anyData;
   JsonData jsonData = check pbAny:unpack(anyData, JsonData);
   io:println(`JSON Data : ${jsonData.toJsonString()}`);
}
