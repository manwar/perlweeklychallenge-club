#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: Perl Weekly Challenge 098
#               Read N-characters
#               https://www.perlweeklychallenge.org
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 02/06/2021 10:10:41 AM
#===============================================================================

use strict;
use warnings;

my $offset = 0;

sub get_n_characters {
    my $what = shift;

    open my $file, '<', $what->[0];
    seek $file, $offset, 0;
    read $file, my $output, $what->[1];
    $offset += $what->[1];
    
    # chomp to fix the problem with end of file
    chomp $output;
    return $output;
}

use Test::More;

is(get_n_characters(['file.txt', 4]), '1234');
is(get_n_characters(['file.txt', 4]), '5678');
is(get_n_characters(['file.txt', 4]), '90');

done_testing;
