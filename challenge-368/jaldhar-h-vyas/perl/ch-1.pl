#!/usr/bin/perl
use 5.038;
use warnings;

sub indices($str, $char) {
    my @positions;
    my $pos = -1;

    while(1) {
        $pos = index $str, $char, $pos + 1;

        if ($pos == -1) {
            last;
        }

        push @positions, $pos;
    }

    return @positions;
}

my ($str, $char) = @ARGV;

my @positions = indices($str, $char);
my $delete = $positions[-1];

for my $pos (@positions) {
    my $next = substr $str, $pos + 1, 1;
    if  ($next > $char) {
        $delete = $pos;
        last;
    }
}

substr $str, $delete, 1, q{};
say $str;
