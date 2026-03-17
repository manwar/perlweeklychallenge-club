#!/usr/bin/env perl

# Perl Weekly Challenge 278 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-278/

use Modern::Perl;

say join(' ',
            map { $_->[0] }
            sort { $a->[1] <=> $b->[1] }
            map { /(.*)(\d+)$/; [$1, $2] }
            @ARGV);
