#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

my $x = shift;
say smallest_multiple($x);

sub smallest_multiple {
    my ($n) = @_;
    return 0 unless $n;

    my $binary = 1 . (0 x (length($n) - 1));
    increment($binary) while $binary % $n;
    $binary
}

sub increment {
    my $pos = rindex $_[0], 0;
    if ($pos > -1) {
        substr $_[0], $pos, 1, '1';
        substr $_[0], $pos + 1, length($_[0]) - $pos - 1,
                         '0' x (length($_[0]) - $pos - 1);
    } else {
        $_[0] = '1' . ('0' x length $_[0]);
    }
}

