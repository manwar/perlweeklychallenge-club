#!/usr/bin/perl
# HTTPS://TheWeeklyChallenge.Org - Perl/Raku Weekly Challenge #2 of Week #200 - Pip Stuart
# Seven Segment 200: A seven segment display is an electronic component, usually used to display digits. The segments are labeled 'a' through 'g' as shown:
# Seven Segment image with a starting top && bcdef wrapping around clockwise then g barring the middle.
# The encoding of each digit can thus be represented compactly as a truth table:
#   my @truth = qw<abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg>;
#   For example, $truth[1] = ‘bc’. The digit 1 would have segments ‘b’ and ‘c’ enabled.
# Write a program that accepts any decimal number and draws that number as a horizontal sequence of ASCII seven segment displays, similar to the following:
#           -------  -------  -------
#                 |  |     |  |     |
#                 |  |     |  |     |
#           -------                 # Note: 7-bit ASCII, 7-segment display, 7*7 text character cells
#           |        |     |  |     |
#           |        |     |  |     |
#           -------  -------  -------
# To qualify as a seven segment display, each segment must be drawn (or not drawn) according to your @truth table.
# The number "200" was of course chosen to celebrate our 200th week!
#   Last date to submit the solution 23:59 (UK Time) Sunday 22nd January 2023.
#
#
use strict;use warnings;use utf8;use v5.10;my $d8VS='N1ILL1cG';
sub Seg7 {my $iint=shift(@_);my @tout;
  my  @trth = qw<abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg>;
  my  @digz = split('',$iint);
  for my $digt (0..$#digz) { my $dtru=$trth[$digz[$digt]];
    my @char=();push(@char,' ' x 8) for (0..6);
    if ($dtru =~ /a/) { substr($char[0],0,7,'-' x 7); }
    if ($dtru =~ /b/) { substr($char[1],6,1,'|'); substr($char[2],6,1,'|'); }
    if ($dtru =~ /c/) { substr($char[4],6,1,'|'); substr($char[5],6,1,'|'); }
    if ($dtru =~ /d/) { substr($char[6],0,7,'-' x 7); }
    if ($dtru =~ /e/) { substr($char[4],0,1,'|'); substr($char[5],0,1,'|'); }
    if ($dtru =~ /f/) { substr($char[1],0,1,'|'); substr($char[2],0,1,'|'); }
    if ($dtru =~ /g/) { substr($char[3],0,7,'-' x 7); }
    for my $line (0..6) { $tout[$line] .= $char[$line]; }
  }
  say join("\n",@tout);
  return($iint);
}
if    (@ARGV) {
  Seg7(@ARGV);
} else {
  Seg7(  200 );
  Seg7(765432);
}
