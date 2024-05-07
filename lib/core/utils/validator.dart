
import 'package:get/get_utils/src/get_utils/get_utils.dart';

validInput(String val, int min, int max, String type) {
  if(type == 'username'){
    if(!GetUtils.isUsername(val)){
      return "Invalid username!";
    }
  }
  if(type == 'text'){
    if(!GetUtils.isLengthGreaterOrEqual(int, max)){
      return "Invalid Text!";
    }
  }
  if(type == 'email'){
    if(!GetUtils.isEmail(val)){
      return "Invalid Email!";
    }
  }
  if(type == 'phone'){
    if(!GetUtils.isPhoneNumber(val)){
      return "Invalid Mobile!";
    }
  }
  if(val.isEmpty){
    return "Input Required!";
  }
  if(val.length < min){
    return "Input can`t be less than $min !";
  }
  if(val.length > max){
    return "Input can`t be more than $max !";
  }

}