import ballerina/http;
import ballerina/io;

service / on new http:Listener(9091) {



    resource function post employee(http:Caller caller, http:Request req) returns error? {
        json|error employee_data = req.getJsonPayload();
        if employee_data is error {
            http:Response response = new;
            response.setJsonPayload({"error": "Invalid JSON"});
            response.statusCode = 400;
            check caller->respond(response);
            return;
        }
        
        io:println("=== Received Employee Data ===");
        io:println("Data: " + employee_data.toString());
        io:println("=============================");

        json mock_data = {
            "columns": ["id", "name", "age", "department", "salary"],
            "rows": [
                [1, "John Doe", 30, "Engineering", 75000.50],
                [2, "Jane Smith", 25, "Marketing", 65000],
                [3, "Bob Wilson", 35, "Sales", 85000.75],
                [4, "Alice Brown", 28, "Engineering", 70000.25],
                [5, "Charlie Davis", 32, "Finance", 80000]
            ]
        };
        
        // Compare mock_data with received data
        json c1 = check mock_data.columns;
        json c2 = check employee_data.columns;

        io:println(">>>>> c1: ", c1);
        io:println(">>>>> c2: ", c2);

        json r1 = check mock_data.rows;
        json r2 = check employee_data.rows;

        io:println(">>>>> r1: ", r1);
        io:println(">>>>> r2: ", r2);

        boolean isRowSame = r1 == r2;
        io:println(">>>>> isRowSame: ", isRowSame);
        
        // Debug: Compare each row individually
        json[] r1Array = <json[]>r1;
        json[] r2Array = <json[]>r2;
        io:println(">>>>> r1Array.length(): ", r1Array.length());
        io:println(">>>>> r2Array.length(): ", r2Array.length());
        
        if r1Array.length() == r2Array.length() {
            foreach int i in 0...(r1Array.length()-1) {
                json row1 = r1Array[i];
                json row2 = r2Array[i];
                
                boolean rowEqual = row1 == row2;
                io:println(">>>>> Row " + i.toString() + " equal: " + rowEqual.toString());
                if !rowEqual {
                    io:println(">>>>> Row " + i.toString() + " r1: " + row1.toString());
                    io:println(">>>>> Row " + i.toString() + " r2: " + row2.toString());
                    
                    // Compare each element in the row
                    json[] row1Array = <json[]>row1;
                    json[] row2Array = <json[]>row2;
                    foreach int j in 0...(row1Array.length()-1) {
                        json elem1 = row1Array[j];
                        json elem2 = row2Array[j];
                        
                        boolean elemEqual = elem1 == elem2;
                        
                        io:println(">>>>>   Element " + j.toString() + " equal: " + elemEqual.toString());
                        if !elemEqual {
                            io:println(">>>>>   Element " + j.toString() + " r1: " + elem1.toString() + " (type: " + (typeof elem1).toString() + ")");
                            io:println(">>>>>   Element " + j.toString() + " r2: " + elem2.toString() + " (type: " + (typeof elem2).toString() + ")");
                        }
                    }
                }
            }
        }
        
        http:Response response = new;
        response.setJsonPayload({
            message: "Employee data received and compared successfully",
            received_data: employee_data,
            comparison_result: {
                columns_match: c1 == c2,
                rows_match: isRowSame
            }
        });
        check caller->respond(response);
    }
}
