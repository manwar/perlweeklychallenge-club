#!/usr/bin/env perl
use v5.26;
use strict;
use warnings;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use autodie;

use List::Util qw(first);

sub main() {
    die "Must provide degree and sequence" unless @ARGV >= 2;
    die "Provide only valid numbers" if defined first { $_ !~ /^[0-9]+$/s } @ARGV;

    my $nth = shift @ARGV;
    my (@sequence) = @ARGV;
    my (@in) = @ARGV;

    for (1..$nth) {
        @sequence = ();
        my $last;
        for my $num (@in) {
            push @sequence, $num - $last if defined $last;
            $last = $num;
        }
        @in = @sequence;
    }

    say join(" ", @sequence);
}

main();

