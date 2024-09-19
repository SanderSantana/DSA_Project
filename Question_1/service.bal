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

service /programme\-development on new http:Listener(9090) {

}
