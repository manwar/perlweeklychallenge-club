#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use Carp;
use List::Util qw{ min max };
use Getopt::Long;

say spnm( 5, 2, -2, 0 );    # 1
say spnm( 1, 8, -1 );       # 2
say spnm( 2, 0, -1 );       # 1
say spnm( 0 .. 12 );        # 13

sub spnm( @array ) {
    my @list = grep { $_ > 0 } @array;    # list to only positive nums
    my %list = map { $_ => 1 } @list;     # hash for easy lookup
    my $max = 1 + max @list;              # highest potential missing number
    for my $i ( 1 .. $max ) {             # starting from lowest potential
        return $i unless $list{$i};       # return if no in lookup
    }
    return -1;                            # just in case
}

