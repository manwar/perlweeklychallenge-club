#!/usr/bin/env perl6
#
#
#       reflect.raku
#
#       Transpose File
#         Submitted by: Mohammad S Anwar
#         You are given a text file.
# 
#         Write a script to transpose the contents of the given file.
# 
#         Input File
#             name,age,sex
#             Mohammad,45,m
#             Joe,20,m
#             Julie,35,f
#             Cristina,10,f
# 
#         Output:
#             name,Mohammad,Joe,Julie,Cristina
#             age,45,20,35,10
#             sex,m,m,f,f
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( Str $input = 'transpose-data.txt' ) ;


my @mat.push( $_.split(',') ) for $input.IO.lines;
my $max = @mat.map( *.elems )
              .max;
my @trans;

for ^@mat.elems -> $i {
    for ^$max -> $j {
        @trans[$j][$i] = @mat[$i][$j];
    }
}

say $_.list for @mat;
say '';
say $_.list for @trans;



