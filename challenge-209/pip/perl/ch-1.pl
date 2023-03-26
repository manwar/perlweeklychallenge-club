#!/usr/bin/perl
# HTTPS://TheWeeklyChallenge.Org - Perl/Raku Weekly Challenge #209 - Pip Stuart
# Task1: Special Bit Characters:  Submitted by: Mohammad S Anwar;  You are given an array of binary bits that ends with 0.
#   Valid sequences in the bit string are:
#     [0   ] -decodes-to-> "a"
#     [1, 0] -       -  -> "b"
#     [1, 1] -       -  -> "c"
#   Write a script to print 1 if the last character is an “a” otherwise print 0.
# Example1:
#   In-put: @bits = (1, 0, 0   )
#   Output:          1           The given array bits can be decoded as 2-bits character (10) followed by 1-bit character (0).
# Example2:
#   In-put: @bits = (1, 1, 1, 0)
#   Output:          0           Possible decode can be 2-bits character (11) followed by 2-bits character (10) i.e. the last character is not 1-bit character.
use strict;use warnings;use utf8;use v5.12;my $d8VS='N3PM6NSe';
sub SBCh {my @bitz = @_;my @bits = @bitz;my $sbch = 0;my $dcds = '';
  while     (@bits        ) {
    if      ($bits[0] == 1) { shift(@bits);
      if    (@bits        ) {
        if  ($bits[0] == 1) { $dcds .= 'c';
        } else              { $dcds .= 'b';
        };                    shift(@bits); }
    }     else              { shift(@bits);
                              $dcds .= 'a'; } }
  $sbch = 1 if              ( $dcds =~ /a$/ );
  printf("(%-10s) => %s;\n", join(', ', @bitz), $sbch);
  return($sbch);
}
if    (@ARGV) {
  SBCh(@ARGV);
} else {
  SBCh(1, 0, 0   ); # => 1;
  SBCh(1, 1, 1, 0); # => 0;
}
