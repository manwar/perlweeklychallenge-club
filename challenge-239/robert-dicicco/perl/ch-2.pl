#!/usr/bin/env perl
=begin
---------------------------------------
AUTHOR : Robert DiCicco
DATE   : 2023-10-18
Challenge 239 Task 02 Consistent Strings ( Perl )
--------------------------------------
=cut
use v5.38;

my @mystr = (["ad", "bd", "aaab", "baa", "badab"],
             ["a", "b", "c", "ab", "ac", "bc", "abc"],
             ["cc", "acd", "b", "ba", "bac", "bad", "ac", "d"]
             );

my @myallow = ("ab","abc","cad");

my $cnt = 0;

sub CheckConsistent($str,$allow) {
    my $output = 0;
    for (my $i = 0; $i < length($str); $i++) {
        my $ch = substr($str,$i,1);
        if (index($allow, $ch) == -1) {
            return 0;
        }
    }
    return 1;
}

while ($cnt < scalar @mystr) {
    my $total = 0;
    my @str = @{$mystr[$cnt]};
    my $allowed = $myallow[$cnt];
    say "Input: \@str = [@str]";
    say "Allowed = $allowed";
    for (my $i = 0; $i < scalar @str; $i++) {
        my $retval = CheckConsistent($mystr[$cnt]->[$i], $allowed);
        $total += $retval;
    }
    $cnt++;
    say "Output: $total\n";
}

=begin
---------------------------------------
SAMPLE OUTPUT

perl .\Consistent.pl

Input: @str = [ad bd aaab baa badab]
Allowed = ab
Output: 2

Input: @str = [a b c ab ac bc abc]
Allowed = abc
Output: 7

Input: @str = [cc acd b ba bac bad ac d]
Allowed = cad
Output: 4
--------------------------------------
=cut
