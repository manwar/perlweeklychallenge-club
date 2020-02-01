#!/usr/bin/env perl
#
# ch-1.pl - Square secret code
#
# Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;

use constant COLUMNS => 8;

my $plaintext = 'The quick brown fox jumps over the lazy dog';

say encode($ARGV[0] // $plaintext);

sub encode {
    local $_ = lc shift;
    s/\s//g;
    my ($i, @s);

    map { $s[$i++ % COLUMNS] .= $_ } split '';

    join ' ', @s;
}
