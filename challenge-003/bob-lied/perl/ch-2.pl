#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl
#=============================================================================
# Copyright (c) 2021, Bob Lied
#=============================================================================
# Perl Weekly Challenge Week 3, Challenge 2
# Create a script that generates Pascal Triangle. Accept number of rows from
# the command line. The Pascal Triangle should have at least 3 rows. For more
# information about Pascal Triangle, check this wikipedia page.
#=============================================================================

use strict;
use warnings;
use v5.32;

use experimental qw/ signatures /;
no warnings "experimental::signatures";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

my $NumRows = shift;
die "Usage: $0 N, where N >= 1" unless $NumRows > 0;

sub pascalTriangle($n)
{
    say "1";
    my $prevRow = [ 1, 1 ];
    say "@$prevRow" if $n >= 2;

    while ( --$n > 1 )
    {
        my $nextRow = [ 1 ];
        for ( my $c = 0 ; $c < scalar(@$prevRow)-1; $c++ )
        {
            push @$nextRow, $prevRow->[$c] + $prevRow->[$c+1];
        }
        push @$nextRow, 1;
        say "@$nextRow";
        $prevRow = $nextRow;
    }

}

pascalTriangle($NumRows);
