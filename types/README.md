# Employee Data Comparison Service

This project demonstrates a simple HTTP REST service in Ballerina that receives employee data from a client and compares it with mock data on the server.

## Problem Statement

The goal is to create a simple HTTP REST service where:
1. A client sends employee data as a JSON object to the server
2. The server compares the received data with predefined mock data
3. The server provides detailed comparison results and logs

## Project Structure

```
types/
├── server/
│   ├── main.bal          # HTTP server with comparison logic
│   ├── Ballerina.toml    # Server package configuration
│   └── .gitignore        # Git ignore file
├── client/
│   ├── main.bal          # HTTP client that sends employee data
│   └── Ballerina.toml    # Client package configuration
└── README.md             # This file
```

## Employee Data Structure

The employee data follows this JSON structure:

```json
{
    "columns": ["id", "name", "age", "department", "salary"],
    "rows": [
        [1, "John Doe", 30, "Engineering", 75000.50],
        [2, "Jane Smith", 25, "Marketing", 65000],
        [3, "Bob Wilson", 35, "Sales", 85000.75],
        [4, "Alice Brown", 28, "Engineering", 70000.25],
        [5, "Charlie Davis", 32, "Finance", 80000]
    ]
}
```

## How to Run

### Prerequisites
- Ballerina installed on your system
- Terminal/Command prompt access

### Step 1: Start the Server

1. Navigate to the server directory:
   ```bash
   cd types/server
   ```

2. Run the server:
   ```bash
   bal run main.bal
   ```

   The server will start on `http://localhost:9091` and wait for requests.

### Step 2: Run the Client

1. Open a new terminal/command prompt
2. Navigate to the client directory:
   ```bash
   cd types/client
   ```

3. Run the client:
   ```bash
   bal run main.bal
   ```

## What Happens

1. **Client sends data**: The client creates employee data and sends it via HTTP POST to `/employee`
2. **Server receives data**: The server receives the JSON payload
3. **Server compares data**: The server compares the received data with its mock data
4. **Detailed logging**: The server logs:
   - Received data
   - Column comparison results
   - Row-by-row comparison
   - Element-by-element comparison with data types
5. **Response**: The server returns a JSON response with comparison results

## Expected Output

### Server Console:
```
=== Received Employee Data ===
Data: {"columns":["id","name","age","department","salary"],"rows":[[1,"John Doe",30,"Engineering",75000.5],...]}
=============================
>>>>> c1: ["id","name","age","department","salary"]
>>>>> c2: ["id","name","age","department","salary"]
>>>>> r1: [[1,"John Doe",30,"Engineering",75000.5],...]
>>>>> r2: [[1,"John Doe",30,"Engineering",75000.5],...]
>>>>> isRowSame: true
>>>>> r1Array.length(): 5
>>>>> r2Array.length(): 5
>>>>> Row 0 equal: true
>>>>> Row 1 equal: true
...
```

### Client Console:
```
=== Simple Employee Data Client ===
Sending employee data to server...
Server response: {"message":"Employee data received and compared successfully","received_data":{...},"comparison_result":{"columns_match":true,"rows_match":true}}
```

## API Endpoints

### POST /employee
- **Description**: Receives employee data and compares it with mock data
- **Request Body**: JSON object with `columns` and `rows` fields
- **Response**: JSON object with comparison results

## Features

- **Type-safe JSON handling**: Uses Ballerina's built-in JSON support
- **Detailed comparison**: Compares columns, rows, and individual elements
- **Error handling**: Proper HTTP error responses for invalid JSON
- **Debugging support**: Extensive logging for troubleshooting
- **Simple architecture**: Clean separation between client and server

## Technologies Used

- **Ballerina**: Programming language for cloud-native applications
- **HTTP**: REST API communication
- **JSON**: Data serialization format
