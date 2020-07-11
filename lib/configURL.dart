class ConfigURL {
  // TODO: fill out description infomation about each api
  // in web use localhost but in android use 10.0.2.2
  // ios work with 127.0.0.1
  // Google cloud IP 34.71.166.221

  // Websocket server IP and port for chat feature
  static String websocketIP = 'ws://business-startup-chat.herokuapp.com';
  // static String websocketIP = 'ws://localhost:5000';
  // static int websocketPort = 8080;

  // Main server URL and Port
  // static String url = "https://business-startup-api.herokuapp.com";
  static String url = "https://business-startup-api.herokuapp.com";
  static String port = ""; // 5000

  // -------- Business APIs --------------------
  static String postApiAppointmentsBusiness = "$url/api/appointments/business";
  static String getApiAppointmentsBusiness = "$url/api/appointments/business";
  static String putApiAvailability = '$url/api/availability';
  static String getApiBusinessinfoMe = '$url/api/businessinfo/me';
  static String postApiBusinessinfo = '$url/api/businessinfo';

  static String postApiloginBusiness = '$url/api/loginBusiness';

// @route    GET api/loginBusiness
// @desc     Get the user information after you login. Grabs user info once you have a tokenBusiness
// @access   Private
// @example  json = {"_id":"5eafa85f7718a51b3a8bbb89","firstName":"god","lastName":"damn","email":"god@email.com","phoneNumber":"456789","firebaseToken":"eHLSJAJwTsO4ghIO","date":"2020-05-04T05:30:07.781Z","__v":0}
  static String getApiloginBusiness = '$url/api/loginBusiness';

  static String postApiRegisterBusiness = '$url/api/registerBusiness';
  static String putApiServices = '$url/api/services';

  // -------- User APIs --------------------
  static String forgotUser = '$url/reset/forget';

  static String getApiBusinessinfoTime = '$url/api/businessinfo/business/';
  // gets the user appointments,
  // desc: date, time, location
  static String getApiAppointments = "$url/api/appointments";
  static String postApiChats = "$url/api/appointments/chats";

// @route    GET api/checkAvailability
// @desc     Get the available times for the business
// @access   Private
// @example {time[8:00, 9:00, 10:00, ...]}
  static String getApiCheckAvailability = "$url/api/checkAvailability/";
  static String putApiAppointments = '$url/api/appointments';
  static String postApiLoginUser = '$url/api/loginUser';

// @route    GET api/loginUser
// @desc     Get the user information after you login. Grabs user info once you have a tokenBusiness
// @access   Private
// example: {"_id":"5ead4e40d36203767688f802","name":"e","email":"e@email.com","firebaseToken":"wschz6wovc","date":"2020-05-02T10:41:04.323Z","__v":0}
  static String getApiLoginUser = '$url/api/loginUser';
  static String postApiRegisterUser = '$url/api/registerUser';
  // @desc   searches businesses near user
  static String postApiBusinessinfoCity = '$url/api/businessinfo/city/';
  // @desc    This is a google api to get the estimated distance
  static String distanceCalculator =
      'https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=Sacramento+Oakpark,CA&destinations=Sacramento,CA&key=AIzaSyA991qIAUlwEuAzM1K1rmNa7hI4bl5c6O4';
}
