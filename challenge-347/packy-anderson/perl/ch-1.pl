#!/usr/bin/env perl
use v5.40;

use Time::Local;
use Time::Piece;

my %months = (
  Jan => 1, Feb => 2, Mar => 3, Apr => 4,  May => 5,  Jun => 6,
  Jul => 7, Aug => 8, Sep => 9, Oct => 10, Nov => 11, Dec => 12
);

sub formatDate($str) {
  my ($day, $month, $year) = split / /, $str;

  my ($dnum, $dord) = $day =~ /(\d+)(\D+)/;
  return "$day has the incorrect ordinal"
    unless
      (($dnum == 1 || $dnum == 21 || $dnum == 31) && $dord eq "st")
      ||
      (($dnum == 2 || $dnum == 22) && $dord eq "nd")
      ||
      (($dnum == 3 || $dnum == 23) && $dord eq "rd")
      ||
      $dord eq "th";
  $day = $dnum; # grab just the numeric portion

  return "Unknown month '$month'"
    unless exists $months{$month};
  $month = $months{$month}; # convert to numeric

  return "Year must be between 1900-2100"
    unless 1900 <= $year && $year <= 2100;

  my $date;
  eval {
    my $epoch = timelocal(0, 0, 0, $day, $month-1, $year);
    $date = Time::Piece->new($epoch);
  };
  if (my $err = $@) { # get rid of line info in the error
    $err =~ s{at .+ line \d+.\n}{};
    return $err;
  }
  return qq/"@{[ $date->date ]}"/;
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  say qq/Output: / . formatDate($str);
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
