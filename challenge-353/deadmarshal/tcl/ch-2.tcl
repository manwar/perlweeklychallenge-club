proc validate_coupon {codes names status} {
  set valids {electronics grocery pharmacy restaurant}
  set res [lmap code $codes name $names stat $status {
    if {[regexp {^[_0-9a-zA-Z]+$} $code] && $name in $valids &&
	[string equal $stat "true"]} {
      set res 1
    } else {
      set res 0
    }
  }]
  return $res
}

puts [validate_coupon {"A123" "B_456" "C789" "D@1" "E123"} \
	{"electronics" "restaurant" "electronics" "pharmacy" "grocery"} \
	{"true" "false" "true" "true" "true"}]

puts [validate_coupon {"Z_9" "AB_12" "G01" "X99" "test"} \
	{"pharmacy" "electronics" "grocery" "electronics" "unknown"} \
	{"true" "true" "false" "true" "true"}]

puts [validate_coupon {"_123" "123" "" "Coupon_A" "Alpha"} \
	{"restaurant" "electronics" "electronics" "pharmacy" "grocery"} \
	{"true" "true" "false" "true" "true"}]

puts [validate_coupon {"ITEM_1" "ITEM_2" "ITEM_3" "ITEM_4"} \
	{"electronics" "electronics" "grocery" "grocery"} \
	{"true" "true" "true" "true"}]

puts [validate_coupon \
	{"CAFE_X" "ELEC_100" "FOOD_1" "DRUG_A" "ELEC_99"} \
	{"restaurant" "electronics" "grocery" "pharmacy" "electronics"} \
	{"true" "true" "true" "true" "false"}]

