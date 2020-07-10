// This is a library I Created for the use of a global variable. I need it to use the variable to get the user input and then transfer that input to the next screen to get the associated times connected to the business ID I found this way the easiest method to implement but I need.

library my_prj.globals;

// These variables are used to save business data to appointment
String businessID = "";
String company = "";
String address = "";
String city = "";
String state = "";
// User and Business use this to save firebaseToken to there repected database
String firebaseToken = "";

// Chat grab userID to save to db on business side
String userID = "";
// Used for chat to grab users name to display in the top nav bar
String userName = "";
// show badges is to show a badge based on if there is a new badge
bool showBadge = false;
