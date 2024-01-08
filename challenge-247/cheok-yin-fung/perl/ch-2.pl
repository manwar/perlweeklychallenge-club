use v5.30.0;
use warnings;
use List::Util qw/max/;
use List::MoreUtils qw/slide/;

sub ch {
    my $str = $_[0];
    my @arr = split "", $str;
    my @pairs = slide {$a.$b} @arr;
    my %freq;
    $freq{$_}++ for @pairs;
    my $mx = max values %freq;
    my @ps = sort {$a cmp $b} grep {$freq{$_} == $mx} keys %freq;
    return $ps[0]; 
}


use Test::More tests=>2;
ok ch("abcdbca") eq "bc";
ok ch("cdeabeabfcdfabgcd") eq "ab";
