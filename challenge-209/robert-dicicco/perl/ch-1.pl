#!/usr/bin/env perl
=begin comment
-------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-21
Challenge 209 Special Bit Chars ( Perl )
-------------------------------------------
=cut
use strict;
use warnings;
use feature 'say';
use Switch::Plain;

my @bits = ([1, 0, 0],[1, 1, 1, 0]);

my $ln = scalar @bits;

my $flag;
my $lastchar = '';
for (0..$ln - 1) {
    my $ref = $bits[$_];
    print "Input: \@list1 = @$ref\n";
    my $ref_len = scalar @$ref;
    $flag = 0;

    for my $x (0..$ref_len-1) {
        nswitch($ref->[$x]) {
            case 1: {
                if ($flag == 0){
                    $flag = 1;
                } else {
                    print 'c ';
                    $lastchar = 'c';
                    $flag = 0;
                }
            }
            case 0: {
                if ($flag == 0) {
                    print 'a ';
                    $lastchar = 'a';
                } elsif ($flag == 1) {
                    print 'b ';
                    $lastchar = 'b';
                    $flag = 0;
                }
            }
        }
    }
    if ($lastchar eq 'a' and $flag == 0) {
        say "\nOutput: 1\n";
    } else {
        say "\nOutput: 0\n";
    }
}

=begin comment
-------------------------------------------
SAMPLE OUTPUT
perl .\SpecialBit.pl
Input: @list1 = 1 0 0
b a
Output: 1

Input: @list1 = 1 1 1 0
c b
Output: 0
-------------------------------------------
=cut
