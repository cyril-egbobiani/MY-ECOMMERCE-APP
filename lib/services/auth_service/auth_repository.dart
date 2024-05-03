abstract class AuthRepository {

  register(String email, String username, String password );

  logIn(String username, String password);
  
  updateProfile(Map<String, dynamic> data);

}


 