#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

print '  x|', (join q{}, map { sprintf('% 4s', $_); } 1 .. 11), "\n",
    '---+', '----' x 11, "\n";

for my $row (1 .. 11) {
    printf("% 3s|%s\n", $row,
        (join q{},
        map { sprintf('% 4s', ($_ < $row) ? q{ } x 4 : $row * $_); } 1 .. 11)
    );
}
