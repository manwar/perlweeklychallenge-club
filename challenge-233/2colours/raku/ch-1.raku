#!/usr/bin/env raku
my token word { '"' <( .*? )> '"' }
subset StringArray of Str where /^ \s* '(' \s* <word>* % [\s* ',' \s*] \s* ')' \s* $/;
sub MAIN($input) {
    die 'Please provide valid input.' unless $input ~~ StringArray;
    my @input = $<word>;
    @input>>.comb>>.Set.Bag.values.map({ $^n * ($^n - 1) div 2 }).sum.say;
}