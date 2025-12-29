import java.util.*;

private static boolean check(String s) {
  if (s.isEmpty()) return false;
  for (char c : s.toCharArray()) {
    if (!Character.isLetterOrDigit(c) && c != '_') return false;
  }
  return true;
}

private static List<Boolean> validate_coupon(String[] codes, String[] names,
                                             String[] status) {
  List<Boolean> res = new ArrayList<>();
  Set<String> bs = new HashSet<>(
    Arrays.asList("electronics", "grocery", "pharmacy", "restaurant"));
  for (int i = 0; i < codes.length; ++i) {
    if (Objects.equals(status[i], "true") &&
      bs.contains(names[i]) && check(codes[i])) {
      res.add(true);
    } else {
      res.add(false);
    }
  }
  return res;
}

void main() {
  IO.println(validate_coupon(new String[]{"A123", "B_456", "C789", "D@1", "E123"},
    new String[]{"electronics", "restaurant", "electronics", "pharmacy", "grocery"},
    new String[]{"true", "false", "true", "true", "true"}));
  IO.println(validate_coupon(new String[]{"Z_9","AB_12","G01","X99","test"},
    new String[]{"pharmacy","electronics","grocery","electronics","unknown"},
    new String[]{"true","true","false","true","true"}));
  IO.println(validate_coupon(new String[]{"_123","123","","Coupon_A","Alpha"},
    new String[]{"restaurant","electronics","electronics", "pharmacy","grocery"},
    new String[]{"true","true","false","true","true"}));
  IO.println(validate_coupon(new String[]{"ITEM_1","ITEM_2","ITEM_3","ITEM_4"},
    new String[]{"electronics","electronics","grocery","grocery"},
    new String[]{"true","true","true","true"}));
  IO.println(validate_coupon(new String[]{"CAFE_X","ELEC_100","FOOD_1","DRUG_A","ELEC_99"},
    new String[]{"restaurant","electronics","grocery",
      "pharmacy","electronics"},
    new String[]{"true","true","true","true","false"}));
}
