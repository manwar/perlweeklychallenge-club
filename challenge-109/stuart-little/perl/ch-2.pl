#!/usr/bin/perl
use warnings;
use v5.12;

# run <script> <space-separated numbers>

use feature qw(signatures);
no warnings qw(experimental::signatures);

use Algorithm::Permute qw(permute);
use List::AllUtils qw(sum min all pairwise);

sub checkSameSums($aref) {
    my $len = scalar @{$aref};
    return all {$_ == sum $aref->@[0,1]} map {sum $aref->@[2*$_-1..(min(2*$_+1,$len-1))]} (1..(int $len/2));
}

sub pprnt($aref) {
    my @letters = ('a'..'g');
    my @strngs = pairwise {qq|$a = $b|} @letters, @{$aref};
    return join(', ', @strngs);
}

my $solCount=0;

permute { if (checkSameSums(\@ARGV)) {$solCount++; my $out = pprnt(\@ARGV); say "Solution: $out\nSum: ${\ do{sum @ARGV[0,1]}}\n"} } @ARGV;

(! $solCount) && do {
    say "No solution."
}
