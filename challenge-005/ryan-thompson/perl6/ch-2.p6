#!/usr/bin/env perl6

# ch-2.p6 - Print word with highest anagram count
#
# Ryan Thompson <rjt@cpan.org>

sub MAIN( ) {
    my %dict = % .classify-list: { word-key($_) }, $*ARGFILES.lines».fc;

    my $max = %dict.values».elems.max;
    .say for %dict.values.grep: { .elems == $max };
}

sub word-key( Str $word ) { $word.fc.comb.sort.join }
