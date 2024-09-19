import ballerina/http;
import ballerina/sql;
import ballerina/time;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

// programme record declaration
type Programme record {|
    readonly int id;

    //mapping record variables to sql table names
    @sql:Column {name: "programme_code"}
    string programmeCode;

    @sql:Column {name: "title"}
    string title;

    @sql:Column {name: "nqf_level"}
    int nqfLevel;

    string faculty;

    string department;

    @sql:Column {name: "registration_date"}
    time:Date registrationDate;

    Course[] courses;
|};

//new programme record declaration
type NewProgramme record {|
    string programmeCode;
    string title;
    int nqfLevel;
    string faculty;
    string department;
    time:Date registrationDate;
    Course[] courses;

|};

//course record declaration
type Course record {

    @sql:Column {name: "programme_code"}
    string programmeCode;

    @sql:Column {name: "course_code"}
    string courseCode;

    @sql:Column {name: "course_name"}
    string courseName;

    @sql:Column {name: "nqf_level"}
    int nqfLevel;

};

//new course declaration
type NewCourse record {
    string courseCode;
    string courseName;
    int nqfLevel;
    string programmeCode;
};

//ballerina table for displaying data
table<Programme> key(id) programmes = table [
        {id: 1, programmeCode: "CS102", title: "Bachelor of Computer Science", nqfLevel: 8, faculty: "Computing and Informatics", department: "Software Engineering", registrationDate: {year: 2014, month: 2, day: 5}, courses: []}
    ];

//error details declaration for displayiong errors
type ErrorDetails record {
    string message;
    string details;
    time:Utc timeStamp;
};

//programme not found declaration for when a programme is not available
type ProgrammeNotFound record {|
    *http:NotFound;
    ErrorDetails body;
|};

//Ballerina database connection and configuration
//Ballerina http Client declaration
mysql:Client programmeDevelopmentDb = check new ("localhost", "root", "root", "programmedevelopmentdb", 3306);

//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
//Code Implementation

service /programme\-development on new http:Listener(9090) {

    //Add  code in here--Numerical order- Confirm curley braces stay in order
    // 2. Retrieves a list of all programmes
    resource function get programmes() returns Programme[]|error {
        stream<Programme, sql:Error?> programmeStream = programmeDevelopmentDb->query(`SELECT * FROM programmes`);
        return from var programme in programmeStream
            select programme;
    }

    // 3. Update an existing programme by programme code
    resource function put programmes/[string programmeCode](NewProgramme updatedProgramme) returns http:Ok|error {
        _ = check programmeDevelopmentDb->execute(`
            UPDATE programmes 
            SET title = ${updatedProgramme.title}, nqf_level = ${updatedProgramme.nqfLevel}, 
                faculty = ${updatedProgramme.faculty}, department = ${updatedProgramme.department}, 
                registration_date = ${updatedProgramme.registrationDate} 
            WHERE programme_code = ${programmeCode};`);
        return http:OK;
    }

    // 4. Retrieve a specific programme by specifying the programme code
    resource function get programmes/[string programme_code]() returns Programme|ProgrammeNotFound|error {
        Programme|sql:Error programme = programmeDevelopmentDb->queryRow(`SELECT * FROM programmes WHERE programme_code = ${programme_code}`);
        if programme is sql:NoRowsError {
            ProgrammeNotFound programmeNotFound = {
                body: {message: string `programme: ${programme_code}`, details: string `programme/${programme_code}`, timeStamp: time:utcNow()}
            };
            return programmeNotFound;
        }
        return programme;
    }







    // 6.retrieve all programmes due for review(AFTER 5 YEARS)
    resource function get programmes/dueForReview() returns Programme[]|error {
        stream<Programme, sql:Error?> programmeStream = programmeDevelopmentDb->query(`SELECT * FROM programmes WHERE DATE_ADD(registration_date, INTERVAL 5 YEAR) <= NOW()`);
        return from var programme in programmeStream
            select programme;
    }

    //7. Retrieve all programmes that belong to the same faculty
    resource function get programmes/faculty/[string faculty]() returns Programme[]|error {
        stream<Programme, sql:Error?> programmeStream = programmeDevelopmentDb->query(` SELECT * FROM programmes WHERE faculty = ${faculty};`);
        return from var programme in programmeStream
            select programme;
    }

}
