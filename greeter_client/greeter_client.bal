import ballerina/io;
import ballerina/protobuf.types.'any as pbAny;
import ballerina/lang.value;

GreeterClient ep = check new ("http://localhost:9090");

public function main() returns error? {
   HelloReply sayHello = check ep->sayHello({name: "Ballerina"});
   
   io:println(`Response : ${sayHello.message}`);
   io:println(`Any Data : ${sayHello.anyData}`);

   io:println(`Any Data Type URL: ${sayHello.anyData.typeUrl}`);
   io:println(`Any Data Value: ${sayHello.anyData.value}`);

   pbAny:Any anyData = sayHello.anyData;

   string outerData = check pbAny:unpack(anyData);
   json outerDataJson = outerData.toJson();
   io:println(`Outer Data JSON: ${outerDataJson}`);
   io:println("Outer Data JSON type:", typeof outerDataJson);

   json someObject = {
    "name": "John Doe",
    "age": 30,
    "email": "john.doe@example.com",
    "salary": 75000
   };
   
   io:println(`Some Object: ${someObject}`);
   io:println("Some Object type:", typeof someObject);

   float salary = check value:ensureType(someObject.salary, float);
   io:println("Salary:", salary);
   io:println("Salary type:", typeof salary);
}