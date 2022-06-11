#!/opt/perl/bin/perl

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-154
#

#
# Run as: perl ch-2.pl
#

#
# Seriously? If you cannot come with anything remotely new, just shut
# down the weekly challenge.
#
# Once again, we're asked to
#   1) produce the first N numbers of an OEIS sequence, with N fixed
#   2) a trivial recurrence 
#   3) filter on/use prime numbers
#
# We did 1) recently in challenge 153-1, 150-2, 148-1, 147-1, 144-1, 133-2, etc
#
# We did 2) recently in challenge 150-1, 149-1, 147-2, 144-2, 136-2, etc
#
# We did 3) recently in challenge 150-2, 147-1, 146-1, 144-1, 141-1, etc
#

#
# This is just sequence A100891
#

#
# To find out whether a number is prime, we could use Math::Util::Prime,
# but we have seen this a gazillion times recently in Colins weekly review.
# We could use trial division, but we have seen that one a gazillion times
# in the same review as well. Same with using a sieve.
#
# It'll be fucking boring to see the same copy and pasted code over
# and over again.
#
# So, today, we'll do something different. To check if a number N is prime,
# we randomly pick a number d, 2 <= d < N, and see if it divides N. If it
# does, N is not prime. If not, we pick a different number, until we either
# have found N to be composite, or we have picked all N - 3 different numbers.
#
# We also won't be generating the Padovan number using a recurrence.
# Instead, we'll just count upwards, and check if we encountered a 
# Padovan number.
#
# Efficient? No, not at all. But better than falling asleep reading the
# same solutioons we seen many times before over and over again.
#
# You might get a cup of tea when running this program. Better, get two cups.
#
# Oh, and we cram the entire program in just a little over two lines.
# Just to make the challenge a bit interesting.
#

sub _{($=,%;)=@_;while(%;<$=-2){$=%($;=2+int rand($=-2))||return;$;{$;}=1}1}($\
,$-,$:,@:)=($/,10,(1)x3,2);++$:&&($:==$:[-2]+$:[-3])&&(push@:,$:)&&_($:)&&print
($:)&&$---while$-
