#let validatecoupon(codes, names, status) = {
  let rx = regex("^[0-9A-Za-z_]+$")
  let dep = ("electronics": true, "grocery": true, "pharmacy": true, "restaurant": true)
  let out = ()
  for i in range(codes.len()) {
    out.push(rx in codes.at(i) and names.at(i) in dep and status.at(i))
  }
  out
}

#let testresult(pass) = {
  if pass {
    text(fill: green, "Pass")
  } else {
    text(fill: red, "Fail")
  }
}

Test 1:
    #testresult(validatecoupon(("A123", "B_456", "C789", "D@1", "E123"), ("electronics", "restaurant", "electronics", "pharmacy", "grocery"), (true, false, true, true, true)) == (true, false, true, false, true))

Test 2:
    #testresult(validatecoupon(("Z_9", "AB_12", "G01", "X99", "test"), ("pharmacy", "electronics", "grocery", "electronics", "unknown"), (true, true, false, true, true)) == (true, true, false, true, false))

Test 3:
    #testresult(validatecoupon(("_123", "123", "", "Coupon_A", "Alpha"), ("restaurant", "electronics", "electronics", "pharmacy", "grocery"), (true, true, false, true, true)) == (true, true, false, true, true))

Test 4:
    #testresult(validatecoupon(("ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4"), ("electronics", "electronics", "grocery", "grocery"), (true, true, true, true)) == (true, true, true, true))

Test 5:
    #testresult(validatecoupon(("CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99"), ("restaurant", "electronics", "grocery", "pharmacy", "electronics"), (true, true, true, true, false)) == (true, true, true, true, false))

