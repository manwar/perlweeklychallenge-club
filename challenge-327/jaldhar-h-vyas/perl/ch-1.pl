#!/usr/bin/perl
use 5.038;
use warnings;

sub setDifference($arr1, $arr2) {
    my %difference = map { $_ => 0 } @{$arr1};

    for my $elem (@{$arr2}) {
        if (exists $difference{$elem}) {
            $difference{$elem}++;
        }
    }

    return grep { !$difference{$_} } keys %difference;
}

sub unique(@list) {
    my %elems;
    for (@list) {
        $elems{$_}++;
    }

    return [keys %elems];
}

my @ints = @ARGV;

my @missing = sort { $a <=> $b } setDifference([1 .. scalar @ints], unique(@ints));
say q{(}, (join q{, }, @missing), q{)};
