#!/usr/bin/perl

use strict;
use warnings;
use List::Util 'min';
use 5.10.1;

sub main (@) {
    my ( $string, $s ) = @_;

    # Convert the first value into a list of integers
    my @list   = ( $string =~ /(-?\d+)/g );
    my @result = ();

    # Sanity checks
    die "The first value must be a list of intergers"  unless scalar(@list);
    die "The second value must be a postive integer\n" unless $s =~ /^[0-9]+$/;
    die "The second value must be at least the number of items in the list\n"
      if $s >= scalar(@list);

    # Go through the list, and calculate the minimum value
    foreach my $i ( 0 .. scalar(@list) - $s ) {
        push @result, min( @list[ $i .. $i + $s - 1 ] );
    }

    # Display the result
    say join ', ', @result;
}

main(@ARGV);
