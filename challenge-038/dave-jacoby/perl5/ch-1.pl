#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings
  qw{ experimental::postderef experimental::smartmatch experimental::signatures };

use Carp;
use DateTime;
use Try::Tiny;

# handle command-line input
if (@ARGV) { say date_finder( $ARGV[0] ) }
# testing data 
else {
    for my $string (qw{2230120 1230120 1230231}) {
        say date_finder($string)
    }
}
exit;

# break the date string into constituent parts, which will cause errors
# if ill-formatted, and then feed that into DateTime, for formatting, but
# also for catching non-existent dates, like 2220931, for example.
sub date_finder ( $string ) {
    my ( $century, $year, $month, $day ) = $string =~ m{
      ^         # start of string
      (\d)      # century value 1-2
      (\d{2})   # year value 00-99
      (\d{2})   # month value 01-12
      (\d{2})   # day value 01-31, plus
      $         # end of string
      }mx;

    croak qq{Bad value: Century $century} if $century != 2 && $century != 1;
    croak qq{Bad value: Month   $month} if $month < 1 || $month > 12;
    croak qq{Bad value: Day     $day}   if $day < 1   || $day > 31;

    try {
        # here we make a DateTime object with the values give us
        # and if those values are invalid, DateTime croaks, which
        # we catch
        my $y    = ( $century == 2 ? '19' : '20' ) . $year;
        my $date = DateTime->new(
            year      => $y,
            month     => $month,
            day       => $day,
            time_zone => 'floating'
        );
        return $date->ymd;
    }
    catch {
        # catching the death of DateTime just to die our own way 
        # MIGHT be antisocial, but I accept it for now.
        croak "Bad value: Input is not a day ($string)";
    };
}
