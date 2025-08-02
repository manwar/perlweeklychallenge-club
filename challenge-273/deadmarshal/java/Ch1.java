public class Ch1 {
  public static void main(String[] args) {
    System.out.println(percentage_of_character("perl",'e'));
    System.out.println(percentage_of_character("java",'a'));
    System.out.println(percentage_of_character("python",'m'));
    System.out.println(percentage_of_character("ada",'a'));
    System.out.println(percentage_of_character("ballerina",'l'));
    System.out.println(percentage_of_character("analitik",'k'));   
  }
  
  private static int percentage_of_character(String str,char c) {
    int count = 0;
    for(int i = 0; i < str.length(); ++i) if(str.charAt(i) == c) count++;
    return Math.round(((float)count/str.length()) * 100);
  } 
}

