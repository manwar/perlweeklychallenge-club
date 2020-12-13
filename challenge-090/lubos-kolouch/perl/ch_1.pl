#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch_1.pl
#
#        USAGE: ./ch_1.pl  
#
#  DESCRIPTION: Perl Weekly Challenge #090
#               Task 1
#               DNA Sequence
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 12/13/2020 02:07:44 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;


sub process_sequence {
    my $seq = shift;

    my %counter;

    my %compl = (
        'T' => 'A',
        'A' => 'T',
        'G' => 'C',
        'C' => 'G',
    );

    my $comp_seq = '';


    for my $item (split //, $seq) {
        $counter{$item}++;
        $comp_seq .= $compl{$item};
    }


    print "$comp_seq\n";
    return $comp_seq;
}

use Test::More;

is(process_sequence('GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG'), 'CATTTGGGGAAAAGTAAATCTGTCTAGCTGAGGAATAGGTAAGAGTCTCTACACAACGACCAGCGGC');

done_testing;
