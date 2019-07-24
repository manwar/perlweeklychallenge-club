#!/usr/bin/env perl6
# Find longest common substring(s) for 2+ cmdline specified strings.
# Set+sort solution inspired by Rosetta code solution.

sub MAIN (*@strings) {

    if @strings.elems < 2 { say "Usage: cmd <string1> <string2> [stringx]..."; exit 1 }

    my @substrings;
    for 0..@strings.elems-1 -> $i {                                         #  $i = string index into @strings
        my $l = @strings[$i].chars;                                         #  $l = string length
        for 0..$l-1 -> $j {                                                 #  $j = start index into string
            for $j..$l-1 -> $k {                                            #  $k = end index of string
                @substrings[$i].push: @strings[$i].substr($j, ($k-$j+1));   #  Generate all substrings from string
            }                                                               #+ in form of 2D-array; 1st dim. is string
        }                                                                   #+ index, 2nd dim. is substring index.
    }
    my @cs = ([∩] @substrings).keys.sort({$^b.chars <=> $^a.chars});        #  Length-sorted intersection of substrings
    if @cs.elems != 0 {
        say "List of longest common substrings: ";                          #  Output lcs if we found any.
        my $i=0; while @cs[$i].chars == @cs[0].chars { say @cs[$i++] };
    } else {
        say "No common substring found";
    }
}
