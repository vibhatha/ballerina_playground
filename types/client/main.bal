import ballerina/http;
import ballerina/io;

// HTTP client to connect to the server
http:Client httpClient = check new ("http://localhost:9091");

public function main() returns error? {
    io:println("=== Simple Employee Data Client ===");
    
    // Create the employee data JSON object
    json employee_data = {
        "columns": ["id", "name", "age", "department", "salary"],
        "rows": [
            [1, "John Doe", 30, "Engineering", 75000.50d],
            [2, "Jane Smith", 25, "Marketing", 65000],
            [3, "Bob Wilson", 35, "Sales", 85000.75d],
            [4, "Alice Brown", 28, "Engineering", 70000.25d],
            [5, "Charlie Davis", 32, "Finance", 80000]
        ]
    };
    
    // Send the data to server
    check sendEmployeeData(employee_data);
}

function sendEmployeeData(json data) returns error? {
    io:println("Sending employee data to server...");
    
    // Create HTTP request
    http:Request request = new;
    request.setJsonPayload(data);
    
    // Send POST request
    http:Response response = check httpClient->post("/employee", request);
    
    // Parse response
    json|error responseJson = response.getJsonPayload();
    if responseJson is error {
        io:println("Error parsing response: " + responseJson.message());
        return;
    }
    
    // Display response
    io:println("Server response: " + responseJson.toString());
}