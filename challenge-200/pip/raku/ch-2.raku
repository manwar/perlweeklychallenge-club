#!/usr/bin/env raku
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
# Note: I've just started learning Raku about a week ago so this is one of my first Raku scripts. I expect my code will typically resemble my probably around
#   intermediate skill-level of Perl5. Just getting stuff to work is cool but then trying to write proper Raku that diverges further is challenging;   -Pip
use v6;my $d8VS='N1ILKwXF';
sub Seg7 {my $iint=@_.shift;my Str @tout[7];
  my  @trth = <abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg>;
  my  @digz = split('',$iint, :skip-empty);
  for 0..@digz.elems-1 -> $dndx { my $dtru=@trth[@digz[$dndx]];
    my Str @char[7]=((' ' x 8) xx 7);
    if ($dtru ~~ /a/) { @char[0].substr-rw(0,7) = '-' x 7; }
    if ($dtru ~~ /b/) { @char[1].substr-rw(6,1) = '|'; @char[2].substr-rw(6,1) = '|'; }
    if ($dtru ~~ /c/) { @char[4].substr-rw(6,1) = '|'; @char[5].substr-rw(6,1) = '|'; }
    if ($dtru ~~ /d/) { @char[6].substr-rw(0,7) = '-' x 7; }
    if ($dtru ~~ /e/) { @char[4].substr-rw(0,1) = '|'; @char[5].substr-rw(0,1) = '|'; }
    if ($dtru ~~ /f/) { @char[1].substr-rw(0,1) = '|'; @char[2].substr-rw(0,1) = '|'; }
    if ($dtru ~~ /g/) { @char[3].substr-rw(0,7) = '-' x 7; }
    for 0..6 -> $line { @tout[$line] ~= @char[$line]; }
  }
  say join("\n",@tout);
  return($iint);
}
if    (@*ARGS) {
  Seg7(@*ARGS);
} else {
  Seg7(  200 );
  Seg7(765432);
}
