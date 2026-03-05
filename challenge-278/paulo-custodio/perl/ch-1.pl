#!/usr/bin/env perl

use Modern::Perl;

say join(' ',
            map { $_->[0] }
            sort { $a->[1] <=> $b->[1] }
            map { /(.*)(\d+)$/; [$1, $2] }
            @ARGV);
