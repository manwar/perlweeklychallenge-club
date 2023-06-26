#!/usr/bin/env perl
=begin comment
-----------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-06-22
Challenge 222 Task 2 Last Member ( Perl )
-----------------------------------------------
=cut
use strict;
use warnings;
use feature 'say';
use List::MoreUtils qw(first_index);

my @allints = @ARGV[0..$#ARGV];

say "Input: \@ints = @allints";
while (1) {
        my @srt = sort(@allints);
        my $ln = scalar @srt;
        if ($ln <= 1) {
            say "Output: $ln";
            exit;
        } else {
            my $lrg = $srt[$ln - 1];
            my $nxt = $srt[$ln - 2];
            my $lrg_index = first_index { $_ eq $lrg } @allints;
            my $nxt_index = first_index { $_ eq $nxt } @allints;
            splice(@allints, $lrg_index, 1);
            splice(@allints, $nxt_index, 1);
            if ($lrg > $nxt){
                unshift(@allints, $lrg - $nxt);
             }
        }
}

=begin comment
-----------------------------------------------
SAMPLE OUTPUT
perl .\LastMember.pl 2 7 4 1 8 1
Input: @ints = 2 7 4 1 8 1
Output: 1

PS G:\Projects\Perl\Challenges> perl .\LastMember.pl 1
Input: @ints = 1
Output: 1

PS G:\Projects\Perl\Challenges> perl .\LastMember.pl 1 1
Input: @ints = 1 1
Output: 0
-----------------------------------------------
=cut
