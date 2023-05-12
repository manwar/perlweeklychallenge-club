#!/usr/bin/env perl
=begin comment
--------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-05-08
Challenge 216 Registration Number ( Perl )
--------------------------------------------
=cut
use strict;
use warnings;
use feature 'say';

my @words = (['abc', 'abcd', 'bcd', 'AB1 2CD'], ['job', 'james', 'bjorg', '007 JB'], ['crack', 'road', 'rac', 'C7 RA2']);

my @out = ();

sub CheckWords {
    my $wd = shift;             # word to be checked
    my $rg = shift;             # registration
    my @arr = split("",$rg);    # split the registration into chars
    my $flag = 0;               # the match flag, set to 1 if reg char is not in word
    foreach my $let (@arr) {
        if ($wd !~ /$let/) {
             $flag = 1;         # set flag to 1 if no match
        }
    }
    push(@out, $wd) if ($flag == 0); # save word if all match
}

for  (@words) {
    my @wds = @{$_};            # get list of words
    my $len = scalar @wds;      # and its length
    print("Input: @wds[0..($len-2)], ");
    my $reg = $wds[$len - 1];   # registration is last entry in words
    print(" \$reg = $reg\n");
    $reg =~ tr/A-Z/a-z/;        # convert all to lower case
    $reg =~ tr/0-9 //d;         # remove spaces and numbers
    for (my $x = 0; $x < $len - 1;$x++) {
        CheckWords($wds[$x],$reg);
    }
    print("Output: @out\n\n");
    @out = ();
 }

=begin comment
 --------------------------------------------
 SAMPLE OUTPUT
perl .\Registration.pl
Input: abc abcd bcd,  $reg = AB1 2CD
Output: abcd

Input: job james bjorg,  $reg = 007 JB
Output: job bjorg

Input: crack road rac,  $reg = C7 RA2
Output: crack rac
--------------------------------------------
=cut



