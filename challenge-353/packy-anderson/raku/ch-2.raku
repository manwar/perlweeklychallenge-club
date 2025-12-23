#!/usr/bin/env raku
use v6;

my @good_names =
  ["electronics", "grocery", "pharmacy", "restaurant"];

sub checkCoupon($code, $name, $status) {
  return 'true' if $status eq 'true'
                && $name eq @good_names.any
                && $code ~~ /^[<alnum>]+$/;
  return 'false';
}

sub validateCoupon(:@codes, :@names, :@status) {
  my @coupons;
  for @codes Z @names Z @status -> ($c, $n, $s) {
    @coupons.push(checkCoupon($c, $n, $s));
  }
  return @coupons;
}

sub quotedList(@list) {
  @list.map({qq{"$_"}}).join(", ");
}

sub solution(:@codes, :@names, :@status) {
  say "Input: \@codes  = ({quotedList(@codes)})";
  say "       \@names  = ({quotedList(@names)})";
  say "       \@status = ({quotedList(@status)})";
  my $output = validateCoupon(:@codes, :@names, :@status)
               .join(", ");
  say "Output: ($output)";
}

say "Example 1:";
solution(
  codes =>  ["A123", "B_456", "C789", 'D@1', "E123"],
  names =>  ["electronics", "restaurant", "electronics",
             "pharmacy", "grocery"],
  status => ["true", "false", "true", "true", "true"]
);

say "\nExample 2:";
solution(
  codes =>  ["Z_9", "AB_12", "G01", "X99", "test"],
  names =>  ["pharmacy", "electronics", "grocery",
             "electronics", "unknown"],
  status => ["true", "true", "false", "true", "true"]
);

say "\nExample 3:";
solution(
  codes =>  ["_123", "123", "", "Coupon_A", "Alpha"],
  names =>  ["restaurant", "electronics", "electronics",
             "pharmacy", "grocery"],
  status => ["true", "true", "false", "true", "true"]
);

say "\nExample 4:";
solution(
  codes =>  ["ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4"],
  names =>  ["electronics", "electronics", "grocery", "grocery"],
  status => ["true", "true", "true", "true"]
);

say "\nExample 5:";
solution(
  codes =>  ["CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99"],
  names =>  ["restaurant", "electronics", "grocery", "pharmacy",
             "electronics"],
  status => ["true", "true", "true", "true", "false"]
);
