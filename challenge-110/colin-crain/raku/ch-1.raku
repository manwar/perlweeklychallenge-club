#!/usr/bin/env perl6
#
#
#       phone-block.raku
#
#       Valid Phone Numbers
#         Submitted by: Mohammad S Anwar
#         You are given a text file.
# 
#         Write a script to display all valid phone numbers in the given text file.
# 
#         Acceptable Phone Number Formats
#             +nn  nnnnnnnnnn
#             (nn) nnnnnnnnnn
#             nnnn nnnnnnnnnn
# 
#         Input File
#             0044 1148820341
#              +44 1148820341
#               44-11-4882-0341
#             (44) 1148820341
#               00 1148820341
# 
#         Output
#             0044 1148820341
#              +44 1148820341
#             (44) 1148820341
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( Str $file = "phone-numbers.txt" ) ;

my $regex   = rx/ [ \d\d\d\d || \(\d\d\) || \+\d\d ] \s \d ** 10 /;

my @numbers  = $file.IO.lines
                       .map({$_~~$regex})
                       .grep({.defined}) ;

say $_.Str.fmt("%16s") for @numbers;

