#!perl.exe

# AUTHOR: Robert DiCicco
# DATE: 2022-10-0003
# Challenge 185 Mask Code ( Perl )

use strict;
use warnings;

my @list = ('ab-cde-123', '123.abc.420', '3abc-0010.xy', '1234567.a', 'a-1234-bc', 'a.b.c.d.e.f');

for my $code ( @list ) {          # get an array entry

  my $cnt = 0;                    # where we are in the string

  my $fnd = 0;                    # count of characters changed

  while ($fnd < 4 ) {             # looking for 4 chars that are alpha numeric

    if ( substr($code,$cnt,1) =~ /[0-9]|[a-z]/ ) {      # check the found char

      substr($code,$cnt,1) = 'x'; # replace with 'x' if it  meets the criteria

      $fnd++;                     # bump the found counter

    }

    $cnt++;                       # bump our string location

  }

  print("$code\n");               # print the completed code

}
