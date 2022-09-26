#https://theweeklychallenge.org/blog/perl-weekly-challenge-184/
#run like: perl ch-1.pl ab1234 cd5678 ef1342
use v5.10;
my $seq='00';
s/../$seq++/e and say for @ARGV;
