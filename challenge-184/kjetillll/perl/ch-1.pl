#https://theweeklychallenge.org/blog/perl-weekly-challenge-184/
#run like: perl ch-1.pl ab1234 cd5678 ef1342
#outputs three lines:   001234 015678 021342
use v5.10;
my $seq='00';
say s/../$seq++/er for @ARGV;
