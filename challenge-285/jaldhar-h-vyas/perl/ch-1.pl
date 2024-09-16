#!/usr/bin/perl
use v5.38;

sub setDifference($arr1, $arr2) {
    my %difference = map { $_ => 0 } @{$arr1};

    for my $elem (@{$arr2}) {
        if (exists $difference{$elem}) {
            $difference{$elem}++;
        }
    }

    return sort grep { !$difference{$_} } keys %difference;
}

my @first;
my @second;

for my $arg (@ARGV) {
    @_ = split /\s+/, $arg;
    push @first, $_[0];
    push @second, $_[1];
}

say join q{ }, setDifference(\@second, \@first);