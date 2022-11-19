# The Weekly Challenge 191
# Task 2 Cute List
# only workable up to $n = 11
use v5.30.0;
use warnings;
use Math::Permutation;

my $n = $ARGV[0] || 1;

sub fac {
    my $ans = 1;
    for (2..$_[0]) {$ans*=$_;}
    return $ans;
}

sub check {
    my $w = substr($_[0], 1, -1);
    my @lst = split ",",$w; 
    my $count = 0;
    for my $i (reverse 0..$n-1) {
        last if !(($lst[$i] % ($i+1) == 0) || (($i+1) % $lst[$i] == 0));
        $count++;
    }
    return ($count == $n) ? 1 : 0;
}

my $p = Math::Permutation->init($n);

my $ans = 0;
for my $i (1..fac($n)) {
    $ans++ if check($p->sprint_wrepr);
    $p->nxt;
}

say $ans;

=pod

1, 2, 3, 8, 10, 36, 41, 132, 250, 700, 750

$ time perl ch-2.pl 11
real	6m49.683s
user	6m48.721s
sys	0m0.192s

