#!/usr/bin/env perl6

# ch-2.p6 - Scrabble word score optimizer
#
# Ryan Thompson <rjt@cpan.org>

use v6;

# Point values for each letter
my %val;
%val{$_} =  1 for < A G I S U X Z >;
%val{$_} =  2 for < E J L R V Y   >;
%val{$_} =  3 for < F D P W       >;
%val{$_} =  4 for < B N           >;
%val{$_} =  5 for < T O H M C     >;
%val{$_} = 10 for < K Q           >;

my %dict;   # Dictionary, populated by MAIN()
my %score;  # Word scores memoization cache, maintained by word-score()

sub MAIN( Str $dict ) {
    %dict = $dict.IO.lines( :chomp )».uc.map( { $_ => 1 } );

    # Letter counts in the bag, flattened such that G3 -> G G G, etc.
    my @bag = < A8 G3 I5 S7 U5 X2 Z5
                E9 J3 L3 R3 V3 Y5
                F3 D3 P5 W5
                B5 N4
                T5 O3 H3 M4 C4
                K2 Q2 >
       .map( { my ($letter, $count) = .comb; ($letter) xx $count } ).flat;

    my @seven = @bag.pick(7); # No need to shuffle
    my %best  = best-word(@seven);

    say "[" ~ @seven ~ "] Best word: %best<word>, Score: %best<score>";
}

# Find the best word (and score) that can be made with @seven letters.
# O(N!) where N = 7 letters drawn from the bag.
sub best-word( @seven ) {
    my %best = ( word => '', score => 0 );

    for @seven.permutations -> @p {
        # Here we check every 1..7-length prefix of the permutation
        my $word = @p.join;
        while $word.chars {
            if %dict{$word}:exists {
                my $score = word-score($word);
                %best<word score> = $word, $score if $score > %best<score>;
            }
            $word = $word.chop;
        }
    }

    %best;
}

# Score a word if not already calculated, and return the score
sub word-score( Str $w ) { %score{$w} //= $w.comb.map( { %val{$_} } ).sum }
