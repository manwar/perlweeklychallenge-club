#!/usr/bin/perl
use warnings;
use 5.030;

sub setDifference {
    my ($arr1, $arr2) = @_;
    my %difference = map { $_ => 0 } @{$arr1};

    for my $elem (@{$arr2}) {
        if (exists $difference{$elem}) {
            $difference{$elem}++;
        }
    }

    return sort grep { !$difference{$_} } keys %difference;
}


my ($arg1, $arg2) = @ARGV;

my @arr1 = split q{ }, $arg1;
my @arr2 = split q{ }, $arg2;

say q{(},
    (
        join q{, }, map { q{[} . ( join q{, }, $_ ) . q{]} } grep { length $_ }
        (
            ( join q{, }, setDifference(\@arr1, \@arr2) ),
            ( join q{, }, setDifference(\@arr2, \@arr1) ),
        )
    ), 
q{)};
