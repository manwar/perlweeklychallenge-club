#!/usr/bin/env raku
# HTTPS://TheWeeklyChallenge.Org - Perl/Raku Weekly Challenge #210 - Pip Stuart
# Task1: Kill and Win:  Submitted by: Mohammad S Anwar;  You are given a list of integers.
#   Write a script to get the maximum points. You are allowed to take out (kill) any integer and remove from the list.
#     However if you do that then all integers exactly one-less or one-more would also be removed. Find out the total of integers removed.
# Example1:
#   In-put: @int = (2, 3, 1)
#   Output:         6                 First we delete 2 and that would also delete 1 and 3. So the maximum points we get is 6.
# Example2:
#   In-put: @int = (1, 1, 2, 2, 2, 3)
#   Output:        11                 First we delete 2 and that would also delete both the 1's and the 3. Now we have (2, 2).
#     Then we delete another 2 and followed by the third deletion of 2. So the maximum points we get is 11.
use v6;my $d8VS='N42MEt4Z';
sub KlWn {my @intz = @_;my $ttli = 0; my @sntz = sort +*, @intz;
  while (@sntz) { if (@sntz.elems - 1) {    my $fndx = 0; # are we just looking to kill one greater than the lowest, if available?
      while ($fndx < (@sntz.elems - 1) && @sntz[0] == @sntz[$fndx]) { $fndx++; }
      my     $kval = @sntz[$fndx     ];$ttli += $kval;splice(@sntz, $fndx     , 1);my $szm1 = @sntz.elems - 1; #say "pivot fndx:$fndx kval:$kval;";
      for  ( 0 ..          $szm1) {                                 #say "_:$_ neg_:" ~ ($szm1 - $_) ~ " snxd:$sntz[$szm1 - $_] sntz:@sntz;";
        if (         @sntz[$szm1 - $_] == $kval + 1 ||
                     @sntz[$szm1 - $_] == $kval - 1) {
          my $logv = @sntz[$szm1 - $_];$ttli += $logv;splice(@sntz, $szm1 - $_, 1);                      #say "  log sndx:$_"~" logv:$logv;";
        } }
    } else { my $lval = pop(@sntz);    $ttli += $lval;                                                   #say "  lst lndx:0" ~" lval:$lval;";
    } }
  printf("(%-16s) => %s;\n", join(', ', @intz), $ttli);
  return($ttli); # I don't see how this total of removed integers is ever going to be any different from just the sum of all the original integers.
}
if    (@*ARGS) {
  KlWn(@*ARGS);
} else {
  KlWn(2, 3, 1         ); # =>  6;
  KlWn(1, 1, 2, 2, 2, 3); # => 11;
}
