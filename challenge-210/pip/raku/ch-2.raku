#!/usr/bin/env raku
# HTTPS://TheWeeklyChallenge.Org - Perl/Raku Weekly Challenge #210 - Pip Stuart
# Task2: Number Collision:  Submitted by: Mohammad S Anwar;  You are given an array of integers which can move in right direction if it is positive and left
#   direction when negative. If two numbers collide then the smaller one will explode. And if both are same then they both explode. We take the absolute value
#     in consideration when comparing.  All numbers move at the same speed, therefore any 2 numbers moving in the same direction will never collide.
#   Write a script to find out who survives the collision.
# Example1:
#   In-put: @list = (2, 3, -1)
#   Output:         (2, 3    ) The numbers 3 and -1 collide and -1 explodes in the end. So we are left with (2, 3).
# Example2:
#   In-put: @list = (3, 2, -4)
#   Output:         (      -4) The numbers 2 and -4 collide and 2 explodes in the end. That gives us (3, -4).
#     Now the numbers 3 and -4 collide and 3 explodes. Finally we are left with -4.
# Example3:
#   In-put: @list = (1,    -1)
#   Output:         (        ) The numbers 1 and -1 both collide and explode. Nothing left in the end.
# Last date to submit the solution 23:59 (UK Time) Sunday 2nd April 2023.
use v6;my $d8VS='N42MEw1A';
sub NCli { my @list = @_;my @mvls = @list;my $done = 0;
  while (!$done) {
    for (0 .. (@mvls.elems - 2)) {
      if      (@mvls[$_] >= 0 && @mvls[$_ + 1] <  0) {
       #say "ndxz:$_ and +1 posi:@mvls[$_] collides with nega:@mvls[$_ + 1]...;";
        if    (abs(@mvls[$_]) == abs(@mvls[$_ + 1])) { splice(@mvls, $_    , 2); }
        elsif (abs(@mvls[$_]) <  abs(@mvls[$_ + 1])) { splice(@mvls, $_    , 1); }
        else                                         { splice(@mvls, $_ + 1, 1); }
        last; } } # any collision and splice should leave the loop to start over before finding the next collision
    $done = 1;
    for (0 .. (@mvls.elems - 1)) {
      if      (@mvls[$_] <  0) { #    look for any positives to the left  of any negatives
        for (      0  .. ($_          - 1)) -> $nndx {
          if ( @mvls[$nndx] >= 0) { $done = 0;last; } }
      } else {                   # && look for any negatives to the right of any positives
        for (($_ + 1) .. (@mvls.elems - 1)) -> $pndx {
          if ( @mvls[$pndx] <  0) { $done = 0;last; } }
      } } }
  printf("(%-8s) => (%4s);\n", join(', ', @list), join(', ', @mvls));
  return(@mvls); }
if    (@*ARGS) {
  NCli(@*ARGS);
} else {
  NCli(2, 3, -1); # => (2, 3);
  NCli(3, 2, -4); # => (-4);
  NCli(1,    -1); # => ();
}
