#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';

sub uniq_prefix {
    my ($words) = @_;
    map {
        my $word = $words->[$_];
        my @copy = @{$words};
        splice @copy, $_, 1;

        my $prefix;
        my $flag = 0;
        for my $size (1..length $word) {
            $prefix = substr $word, 0, $size;
            unless (grep { /^$prefix/ } @copy ) {
                $flag = 1;
                last;
            }
        }
        $flag?$prefix:'na';
    } 0..$#{$words};
}

my @words = @ARGV?@ARGV:qw(alphabet book carpet cadmium cadeau alpine);
my @unique_prefix = uniq_prefix(\@words);
say "[@unique_prefix]";

=begin
perl .\ch-2.pl alphabet book carpet cadmium cadeau alpine
[alph b car cadm cade alpi]

#Example of input where there is longer match in the end. 
#alphabet .. alpine .. alphanumeric
perl .\ch-2.pl alphabet book alpine carpet cadmium cadeau alphanumeric
[alphab b alpi car cadm cade alphan]
=cut