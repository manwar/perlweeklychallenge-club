#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 11002.pl
#
#        USAGE: ./11002.pl  INFILE OUTFILE [ INENC [ OUTENC ]]
#
#  DESCRIPTION: Transpose the given CSV file, writing results to the
#  given output file.
#
#      OPTIONS: Unless provided, the input file encoding defaults to UTF-8.
#               Unless provided, the output file encoding defaults to
#               the same as the input file encoding.
# REQUIREMENTS: Array::Transpose, Text::CSV, Perl 5.10 or newer
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 26/04/21
#===============================================================================

use strict;
use warnings;
use 5.010;
use Array::Transpose;
use Text::CSV 1.90 'csv';

my $enc_in  = $ARGV[2] // 'UTF-8';
my $enc_out = $ARGV[3] // $enc_in;
my $array   = csv (in => $ARGV[0], encoding => $enc_in);
my @tr      = transpose ($array);

csv (in => \@tr, out => $ARGV[1], encoding => $enc_out);
