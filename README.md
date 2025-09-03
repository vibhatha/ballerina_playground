# Sample Ballerina gRPC 

## Server

```bash
# bal grpc --mode service --input helloworld.proto --output greeter_service/

cd greeter_service 
bal run
```

## Client

```bash
# bal grpc --mode client --input helloworld.proto --output greeter_client/

cd greeter_client
bal run
```

### Output

```
Response : Hello Ballerina
Any Data : {"typeUrl":"type.googleapis.com/google.protobuf.StringValue","value":"0A3D7B226E616D65223A224A6F686E20446F65222C2022616765223A33302C2022656D61696C223A226A6F686E2E646F65406578616D706C652E636F6D227D"}
Any Data Type URL: type.googleapis.com/google.protobuf.StringValue
Any Data Value: 0A3D7B226E616D65223A224A6F686E20446F65222C2022616765223A33302C2022656D61696C223A226A6F686E2E646F65406578616D706C652E636F6D227D
```
