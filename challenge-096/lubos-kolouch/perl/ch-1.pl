#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: Perl Weekly Challenge #096
#               https://perlweeklychallenge.org/blog/perl-weekly-challenge-096/
#               Task 1 - Reverse Words
#  
#       AUTHOR: Lubos Kolouch
#      VERSION: 1.0
#      CREATED: 01/23/2021 11:20:18 AM
#===============================================================================

use strict;
use warnings;

sub reverse_words {
    my $what = shift;

    # split leaves the initial space
    $what =~ s/^\s+//;

    return  join ' ', reverse split /\s+/, $what;
}

use Test::More;

is(reverse_words('The Weekly Challenge'), 'Challenge Weekly The');
is(reverse_words('    Perl and   Raku are  part of the same family  '), 'family same the of part are Raku and Perl');

done_testing;
