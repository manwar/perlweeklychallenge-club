#!/usr/bin/perl
use 5.030;
use warnings;

sub distinct {
    my ($arr) = @_;
    my %unique;
    my @distinct;

    for my $elem (@{$arr}) {
        $unique{$elem}++;
        push @distinct, "$elem$unique{$elem}";
    }

    return @distinct;
}

sub intersection {
    my @sets = @_;
    my %count;

    for my $set (@sets) {
        for my $elem (distinct($set)) {
            if (!exists $count{$elem}) {
                $count{$elem} = 1;
            } else {
                $count{$elem}++;
            }
        }
    }

    return [ map { [split //, $_]->[0] } grep { $_ if $count{$_} == scalar @sets } keys %count ];
}

my @words = map { [ split //, $_ ] } @ARGV;

say 
    q{(},
    ( join q{, }, map { "\"$_\"" } ( sort @{intersection( @words )} ) ),
    q{)};
