public class Ch1 {
  public static void main(String[] args) {
    System.out.println(circular(new String[]{"perl","loves","scala"}));
    System.out.println(
      circular(new String[]{"love","the","programming"}));
    System.out.println(
      circular(new String[]{"java","awk","kotlin","node.js"}));
  }

  private static boolean circular(String[] arr) {
    for(int i = 0; i < arr.length-1; ++i) {
      if(arr[i].charAt(arr[i].length()-1) != arr[i+1].charAt(0))
	return false;
    }
    return true;
  }
}

