#!/usr/bin/env raku

# I'm going with a pangram in which each word solves exactly 1 new letter.

my $ltrs = 'a'..'z';
my $set  = SetHash.new;

for 'dictionary.txt'.IO.lines
{
    my $new = .comb (-) $set;

    if $new == 1
    {
        $set.set: ~$new;
        printf("%-15s%s%s\n", $_, ' added ', ~$new);
    }

    last unless $ltrs (-) $set;
}   
