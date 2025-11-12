#!/usr/bin/env raku
use v6;

my %months = (
  Jan => 1, Feb => 2, Mar => 3, Apr => 4,  May => 5,  Jun => 6,
  Jul => 7, Aug => 8, Sep => 9, Oct => 10, Nov => 11, Dec => 12
);

sub formatDate($str) {
  my ($day, $month, $year) = $str.split(" ");

  my $m = $day ~~ /(\d+)(\D+)/;
  return "$day has the incorrect ordinal"
    unless
      (($m[0] == 1 || $m[0] == 21 || $m[0] == 31) && $m[1] eq "st")
      ||
      (($m[0] == 2 || $m[0] == 22) && $m[1] eq "nd")
      ||
      (($m[0] == 3 || $m[0] == 23) && $m[1] eq "rd")
      ||
      $m[1] eq "th";
  $day = $m[0]; # grab just the numeric portion

  return "Unknown month '$month'"
    unless %months{$month}:exists;
  $month = %months{$month}; # convert to numeric

  return "Year must be between 1900-2100"
    unless 1900 <= $year <= 2100;

  my $date;
  try {
    $date = Date.new($year, $month, $day);
  }
  return $! if $!;
  return qq/"$date"/;
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  say qq/Output: / ~ formatDate($str);
}

say "Example 1:";
solution("1st Jan 2025");

say "\nExample 2:";
solution("22nd Feb 2025");

say "\nExample 3:";
solution("15th Apr 2025");

say "\nExample 4:";
solution("23rd Oct 2025");

say "\nExample 5:";
solution("31st Dec 2025");

say "\nExample Year Too Big:";
solution("31st Dec 2525");

say "\nExample Year Too Small:";
solution("31st Dec 1825");

say "\nExample Bad Ordinal:";
solution("31nd Dec 2025");

say "\nExample Bad Month:";
solution("30th Avril 2025");

say "\nExample Bad Date:";
solution("31st Feb 2025");
