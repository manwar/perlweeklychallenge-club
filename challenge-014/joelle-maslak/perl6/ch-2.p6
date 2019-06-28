#!/usr/bin/env perl6
use v6;

unit sub MAIN(Str:D $dict? = '/usr/share/dict/words');

my $states = Set.new: «
    AK AL AR AZ CA CO CT DE FL GA
    HI IA ID IL IN KS LA MA MD ME
    MI MO MN MS MT NM NC ND NE NH
    NJ NM NV NY OH OK OR PA RI SC
    SD TN TX UT VA VT WA WI WV WY
»;

# Get list of all possible candidate words
my @candidates = $dict.IO.lines.race.grep: { is-candidate($_) };

# Find the longest one(s) and print them
my @longest = @candidates.grep: { .chars == @candidates».chars.max };
say "Longest matches: ", @longest.join(" ");

sub is-candidate(Str:D $word -->Bool:D) {
    # We don't want words that are not some multiple of 2 characters
    # long.
    return False unless $word.chars %% 2;

    # We'll use this array for the component parts of the word (the
    # potential state abbreviations), upper casing them.
    my @parts = $word.comb(2)».uc;

    # A state abbreviation can only appear once.
    return if Bag.new(@parts).first( { $_.value > 1 } ).defined;

    # We also don't want any words that contain two letters that are not
    # a state abbreviation.
    return if @parts.first( { ! $states{$_} } );

    # So we know that the word 
    return True;
}


