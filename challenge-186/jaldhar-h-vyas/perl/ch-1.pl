#!/usr/bin/perl
use 5.030;
use warnings;

sub zip {
    my @a = @{ $_[0] };
    my @b = @{ $_[1] };

    my @result;
    for my $i (0 .. scalar @b - 1) {
        push @result, $a[$i], $b[$i];
    }
    return @result;
}

my @a = qw/1 2 3/;
my @b = qw/a b c/;

say join q{ }, zip(\@a, \@b);
say join q{ }, zip(\@b, \@a);
