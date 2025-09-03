import ballerina/io;

GreeterClient ep = check new ("http://localhost:9090");

public function main() returns error? {
   HelloReply sayHello = check ep->sayHello({name: "Ballerina"});
   
   io:println(`Response : ${sayHello.message}`);
   io:println(`Any Data : ${sayHello.anyData}`);

   io:println(`Any Data Type URL: ${sayHello.anyData.typeUrl}`);
   io:println(`Any Data Value: ${sayHello.anyData.value}`);
}