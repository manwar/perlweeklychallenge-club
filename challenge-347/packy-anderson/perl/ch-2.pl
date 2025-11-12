#!/usr/bin/env perl
use v5.40;

sub formatPhone2($phone, $formatted) {
  if (length($phone) < 4) {
    $formatted . $phone;
  }
  elsif (length($phone) == 4) {
    $formatted . substr($phone, 0,2) . "-" . substr($phone, 2,2);
  }
  else {
    formatPhone2(
      substr($phone, 3),
      $formatted . substr($phone, 0, 3) . "-"
    );
  }
}

sub formatPhone($phone) {
  $phone =~ s/\D+//g;
  formatPhone2($phone, "");
}

sub solution($phone) {
  say qq/Input: \$phone = "$phone"/;
  say qq/Output: "@{[formatPhone($phone)]}"/;
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

