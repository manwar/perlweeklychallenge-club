#!/usr/bin/perl
use 5.40.1;
use warnings;

my $n = shift;
my @list = @ARGV;

if (scalar @list < $n) {
    say "-1";
} else {
    my $len = int(scalar @list / $n);
    my $rem = scalar @list % $n;

    my @groups = ($len) x $n;
    my $i = 0;
    while ($rem != 0) {
        $groups[$i++] += 1;
        $rem--;
    } 

    my @results = map { [ splice @list, 0, $_ ] } @groups;

    say q{(},
        (join q{, }, map { q{(} . (join q{,}, @{$_}) . q{)} } @results),
    q{)};
}
