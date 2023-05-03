#!/usr/bin/env perl
=begin pod
-----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-05-02
Challenge 215 Number Placement ( Perl )
-----------------------------------------
=cut
use strict;
use warnings;
use feature 'say';
use IO::Prompter;

sub CheckZeroes {
    my $arr = shift;
    my $cnt = shift;
    my $zcnt = $cnt * 2;
    while($zcnt < scalar @$arr - 1) {
        if ((@$arr[$zcnt] == 0) && (@$arr[$zcnt-1] != 1)) {
             @$arr[$zcnt] = 1;
        }
        $zcnt++;
    }
    say "Output: 1 = ",@$arr;
}

sub HowManyZeroes {
    my $arr = shift;
    my $z = 0;
    my $zcnt = 0;
    while ($z < scalar @$arr - 1) {
        if (@$arr[$z] == 0) {
            $zcnt++;
        }
        $z++;
    }
    return $zcnt;
}
my $testarr = prompt -num, 'Enter an array as a string of numbers ';
my @numbers = split(//,$testarr);
chomp(@numbers);

my $count = prompt -num, 'Enter count ';

#say "Input: \@numbers = ",@numbers;
#say "Count = ",$count;
my $zeroes = HowManyZeroes(\@numbers);
if ($zeroes < $count * 2) {
    say "Output: 0";
} else {
    CheckZeroes(\@numbers,$count-1);
}

=begin pod
-----------------------------------------
SAMPLE OUTPUT
perl .\NumberPlacement.pl
Enter an array as a string of numbers 10001
Enter count 1
Output: 1 = 10101

perl .\NumberPlacement.pl
Enter an array as a string of numbers 10001
Enter count 2
Output: 0

perl .\NumberPlacement.pl
Enter an array as a string of numbers 101000001
Enter count 3
Output: 1 = 101010101
-----------------------------------------
=cut
