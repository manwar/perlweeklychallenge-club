#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my ($m, $n) = @_;

    # Sanity check
    die "You must provide two values\n" unless defined $m and defined $n;
    die "The first value is not a positive integer" unless $m =~ /^[1-9][0-9]*$/;
    die "The second value is not a positive integer" unless $n =~ /^[1-9][0-9]*$/;

    # Show the multiplication table
    my %seen = ();
    my $length = length($m * $n);
    my $format = "%${length}s |" . ( " %${length}s" x $n) ."\n";
    printf $format, 'x', 1 .. $n;
    say '-' x ($length+1), '+', '-' x (($length+1)*$n);
    foreach my $o (1 .. $m) {
        my @row = map { $_ * $o } 1..$n;
        $seen{$_} = 1 foreach @row;
        printf $format, $o, @row;
    }

    my @numbers = sort { $a <=> $b } keys %seen;
    say '';
    say 'Distinct Terms: ', join ', ', @numbers;
    say "Count: ", scalar(@numbers);

}

main(@ARGV);
