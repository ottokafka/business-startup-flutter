class ConfigURL {
  // TODO: fill out description infomation about each api
  // in web use localhost but in android use 10.0.2.2
  // ios work with 127.0.0.1
  // Google cloud IP 34.71.166.221

  // Websocket server IP and port for chat feature
  static String websocketIP = '34.71.166.221' + ":";
  static int websocketPort = 8080;

  // Main server URL and Port
  static String url = "34.71.166.221" + ":";
  static String port = "5000";

  // -------- Business APIs --------------------
  static String postApiAppointmentsBusiness =
      "http://$url$port/api/appointments/business";
  static String getApiAppointmentsBusiness =
      "http://$url$port/api/appointments/business";
  static String putApiAvailability = 'http://$url$port/api/availability';
  static String getApiBusinessinfoMe = 'http://$url$port/api/businessinfo/me';
  static String postApiBusinessinfo = 'http://$url$port/api/businessinfo';

  static String postApiloginBusiness = 'http://$url$port/api/loginBusiness';

// @route    GET api/loginBusiness
// @desc     Get the user information after you login. Grabs user info once you have a tokenBusiness
// @access   Private
// @example  json = {"_id":"5eafa85f7718a51b3a8bbb89","firstName":"god","lastName":"damn","email":"god@email.com","phoneNumber":"456789","firebaseToken":"eHLSJAJwTsO4ghIO","date":"2020-05-04T05:30:07.781Z","__v":0}
  static String getApiloginBusiness = 'http://$url$port/api/loginBusiness';

  static String postApiRegisterBusiness =
      'http://$url$port/api/registerBusiness';
  static String putApiServices = 'http://$url$port/api/services';

  // -------- User APIs --------------------
  static String forgotUser = 'http://$url$port/reset/forget';

  static String getApiBusinessinfoTime =
      'http://$url$port/api/businessinfo/business/';
  // gets the user appointments,
  // desc: date, time, location
  static String getApiAppointments = "http://$url$port/api/appointments";
  static String postApiChats = "http://$url$port/api/appointments/chats";

// @route    GET api/checkAvailability
// @desc     Get the available times for the business
// @access   Private
// @example {time[8:00, 9:00, 10:00, ...]}
  static String getApiCheckAvailability =
      "http://$url$port/api/checkAvailability/";
  static String putApiAppointments = 'http://$url$port/api/appointments';
  static String postApiLoginUser = 'http://$url$port/api/loginUser';

// @route    GET api/loginUser
// @desc     Get the user information after you login. Grabs user info once you have a tokenBusiness
// @access   Private
// example: {"_id":"5ead4e40d36203767688f802","name":"e","email":"e@email.com","firebaseToken":"wschz6wovc","date":"2020-05-02T10:41:04.323Z","__v":0}
  static String getApiLoginUser = 'http://$url$port/api/loginUser';
  static String postApiRegisterUser = 'http://$url$port/api/registerUser';
  // @desc   searches businesses near user
  static String postApiBusinessinfoCity =
      'http://$url$port/api/businessinfo/city/';
  // @desc    This is a google api to get the estimated distance
  static String distanceCalculator =
      'https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=Sacramento+Oakpark,CA&destinations=Sacramento,CA&key=AIzaSyA991qIAUlwEuAzM1K1rmNa7hI4bl5c6O4';
}
