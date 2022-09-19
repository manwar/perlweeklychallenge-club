use strict;
use warnings;
use feature qw/say/;

for my $test ("Perl Weekly Challenge", "Long Live Perl") {
    my @let = split //, $test;
    my %h;
    $h{$_}++ for @let;
    for my $i (0..$#let) {
        say "$test: $i" and last if $h{$let[$i]} == 1;
    }
}
