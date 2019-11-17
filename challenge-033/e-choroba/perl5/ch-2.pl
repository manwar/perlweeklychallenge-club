#!/usr/bin/perl
use warnings;
use strict;
use utf8;

use open OUT => ':encoding(UTF-8)', ':std';

my $MAX = shift;

my $width = 1 + length($MAX ** 2);

sub line {
    my ($header, $from) = @_;
    printf "%${width}s │", $header;
    printf "%${width}s", "" for 1 .. $from - 1;
    printf "%${width}d", $from * $_ for $from .. $MAX;
    print "\n";
}

line('×', 1);
print '─' x (1 + $width), '┼', '─' x ($width * $MAX), "\n";
for my $x (1 .. $MAX) {
    line($x, $x);
}

