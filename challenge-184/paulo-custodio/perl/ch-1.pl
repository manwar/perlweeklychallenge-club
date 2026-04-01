#!/usr/bin/env perl

# Perl Weekly Challenge 184 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-184/

use Modern::Perl;

sub sequence {
    my(@in) = @_;
    my %keys;
    @in = map {/([a-z]+)(\d+)/ and [$1, $2]} @in;
    for (@in) { $keys{$_->[0]}=0; }
    my $id = 0; for (sort keys %keys) { $keys{$_} = $id++; }
    @in = sort map {sprintf("%02d%s", $keys{$_->[0]}, $_->[1])} @in;
    return @in;
}

@ARGV or die "usage: ch-1.pl list...\n";
say "(", join(", ", sequence(@ARGV)), ")";
