#!/usr/bin/env perl
use strict; use warnings;
use v5.26;

# tested with: perl perl/ch-1.pl --debug 5 2 -2 0

our $d = 0;

sub smallestPositiveNumber {
    my @unsignedOnly =
        sort grep { $_ >= 0 } 0, @_; # add zero(0) to better indexing
    say join (", ", @unsignedOnly ) if$d;

    my @set;
    $set[$_] = 'set' for @unsignedOnly;
    push @set, undef;
    if ($d) {
        say join(", ", map { "$_ => ".($set[$_] // 'gap') } 0..$#set );
    }

    defined $set[$_] or return $_ for 1..@set;
}

my @filteredARGV;

for (@ARGV) {
    /^-(d|v|-*debug|-*verbose)$/ and ( $d = 1, next );

    (  /^(-h|--*help)$/ or ($_+0) ne $_ )
        and say("perl ch-1.pl <interger> ..."), exit 0;

    push @filteredARGV, $_;
}

say( $d?"therefore: ":"", smallestPositiveNumber( @filteredARGV ) );
