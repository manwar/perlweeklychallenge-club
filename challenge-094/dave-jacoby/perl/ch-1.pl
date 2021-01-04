#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use JSON;
my $json = JSON->new->space_after;

my @input  = qw{ opt bat saw tab pot top was new };
my $output = group_output(@input);
say $json->encode($output);
say '';

$output = group_output('x');
say $json->encode($output);
say '';

# folding case might be a good idea,
# but not part of the task

sub group_output ( @input ) {

    # we often do keys %hash to handle a hash table
    # in the general sense, but remember you can
    # do the same with values.

    my %hash;
    for my $w (@input) {

        # here we use sort_letters to get a canonical
        # key to identify anagrams.
        push $hash{ sort_letters($w) }->@*, $w;
    }

    # and the results become an array of arrays.
    my @array = values %hash;
    return wantarray ? @array : \@array;
}

sub sort_letters ( $word ) {

    # read this backwards:
    return join '',         #  rejoin the array
        sort                #  sort the array alphabetically
        split //, $word;    #  break word into letter array
}
