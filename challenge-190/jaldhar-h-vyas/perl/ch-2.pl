#!/usr/bin/perl
use 5.030;
use warnings;

my $s = shift // die "Need a string of digits!\n";
my @combos;

push @combos, [ split //, $s ];
if ((length $s) % 2) {
    push @combos, [ $s =~ /(.) ([0-9]{2})+ /gx ];
    push @combos, [ $s =~ /([0-9]{2})+ (.) /gx ];

} else {
    push @combos, [ $s =~ /([0-9]{2})/g ];
}

for my $n (0 .. (length $s) - 2) {
    my @chars = split //, $s;
    my $long = join q{}, @chars[$n, $n + 1];
    splice @chars, $n, 2, $long;
    push @combos, \@chars;
}

my %results;

for my $combo (@combos) {
    unless ( scalar grep { $_ < 1 || $_ > 26 } @{$combo}) {
        $results{ join q{}, map { ('A' .. 'Z')[$_ -1] } @{$combo} }++;
    }
}

say join q{, }, sort keys %results;
