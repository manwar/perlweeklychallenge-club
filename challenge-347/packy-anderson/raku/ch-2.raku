#!/usr/bin/env raku
use v6;

multi formatPhone($phone where $phone.chars < 4, $formatted) {
  $formatted ~ $phone;
}

multi formatPhone($phone where $phone.chars == 4, $formatted) {
  $formatted ~ $phone.substr(0..1) ~ "-" ~ $phone.substr(2..3);
}

multi formatPhone($phone, $formatted) {
  formatPhone(
    $phone.substr(3),
    $formatted ~ $phone.substr(0..2) ~ "-"
  );
}

multi formatPhone(Str $phone is copy) {
  $phone ~~ s:global/\D+//;
  formatPhone($phone, "");
}

sub solution($phone) {
  say qq/Input: \$phone = "$phone"/;
  say qq/Output: "{formatPhone($phone)}"/;
}

say "Example 1:";
solution("1-23-45-6");

say "\nExample 2:";
solution("1234");

say "\nExample 3:";
solution("12 345-6789");

say "\nExample 4:";
solution("123 4567");

say "\nExample 5:";
solution("123 456-78");
