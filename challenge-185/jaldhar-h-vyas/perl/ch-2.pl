#!/bin/perl
use 5.030;
use warnings;

sub transform {
    my $transformed = shift;

    for (1 .. 4) {
        $transformed =~ s/[a-z0-9]/\0/;
    }
    $transformed =~ s/\0/x/g;

    return "'$transformed'";
}

say q{(} . (join q{, }, map transform($_), @ARGV) . q{)};
