#!/usr/bin/perl
use 5.40.1;
use warnings;

sub first($needle, @haystack) {

    my $index = 0;
    for my $i (@haystack) {
        $index++;
        if ($i == $needle) {
            return $index;
        }
    }

    return undef;
}

my ($order, $friends) = @ARGV;

my @order = split /\s+/, $order;
my @friends = split /\s+/, $friends;

say q{(},
    (join q{, }, sort { first($a, @order) <=> first($b, @order) } @friends),
    q{)};

