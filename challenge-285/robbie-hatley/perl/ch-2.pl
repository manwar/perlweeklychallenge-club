#!/usr/bin/env -S perl -C63

=pod

The Weekly Challenge #285-2: "Making Change"
Submitted by: David Ferrone
Compute the number of ways to make change for a given value in
cents by using the coins Penny, Nickel, Dime, Quarter and
Half-dollar. Order of coin selection does not matter.
A penny (P) is equal to 1 cent.
A nickel (N) is equal to 5 cents.
A dime (D) is equal to 10 cents.
A quarter (Q) is equal to 25 cents.
A half-dollar (H) is equal to 50 cents.

Example 1:
Input: $amount = 9
Ouput: 2
1: 9P
2: N + 4P

Example 2:
Input: $amount = 15
Ouput: 6
1: D + 5P
2: D + N
3: 3N
4: 2N + 5P
5: N + 10P
6: 15P

Example 3:
Input: $amount = 100
Ouput: 292

Solution in Perl written by Robbie Hatley on Fri Sep 06, 2024.

Input is by @ARGV or internal array. If using @ARGV, provide one input which must be a single-quoted array of
non-negative integers in proper Perl syntax, like so:
./ch-2.pl '(0, 13, 74, 203)'

Output is to STDOUT and will be each input followed by its corresponding output.

=cut

use v5.36;
use utf8;
$"=', ';

sub make_change :prototype($) ($x) {
   return 'Error!' if $x !~ m/^0$|^[1-9][0-9]*$/;
   my @ways;
   my $count = 0;
   for my $H ( 0 .. int($x/50) ) {
      for my $Q ( 0 .. int(($x-50*$H)/25) ) {
         for my $D ( 0 .. int(($x-50*$H-25*$Q)/10) ) {
            for my $N ( 0 .. int(($x-50*$H-25*$Q-10*$D)/5) ) {
               my $P = $x-50*$H-25*$Q-10*$D-5*$N;
               ++$count;
               push @ways, "${count}: ${H}H ${Q}Q ${D}D ${N}N ${P}P";
            }
         }
      }
   }
   return @ways;
}

my @values = @ARGV ? eval($ARGV[0]) : (9, 15, 100);

for my $value (@values) {
   my @ways = make_change($value);
   say '';
   say "Ways of making change for $value¢:";
   say for @ways;
}
