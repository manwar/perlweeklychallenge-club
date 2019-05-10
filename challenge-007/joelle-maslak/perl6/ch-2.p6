#!/usr/bin/env perl6
use v6;

#
# Copyright © 2019 Joelle Maslak
# All Rights Reserved - See License
#

# Some changes between the challenge assumptions and what this handles:
#
# Words in the word list don't have to be the same length as the start
# and end words.  Words in the list that differ in length from the
# start/end words are just excluded from consideration.
#
# This doesn't care if the words in the list are alphabetical.
#
# Duplicates in the world list won't cause an issues.

sub MAIN(Str:D $src, Str:D $dst, Str:D $file = '/usr/share/dict/words') {
    die ("Words must be same length") if $src.chars ≠ $dst.chars;

    if $src eq $dst {
        say "$src";
        exit;
    }

    if $src.chars == 1 {
        say "$src $dst";
        exit;
    }

    my @srcword = $src.comb;
    my @dstword = $dst.comb;

    my @words = $file.IO.lines.sort.unique.map( *.comb )».fc;
    @words = @words.grep( *.elems == $src.chars );

    my @pending.push: { word => @srcword, path => [ ] };
    state %paths;
    %paths<$srcword> = [];

    while @pending.elems {
        my $checkword = @pending.shift;
        my $joinedcheck = $checkword<word>.join;
        my @potentials = find_one_off($checkword<word>, @words);

        for @potentials -> $potential {
            # If we have found a path already, don't search along longer
            # paths.
            next if %paths{$dst}:exists and %paths{$dst}.elems < ($checkword<path>.elems + 1);
           
            my $joined = $potential.join;

            # If we've visited a node already and it's got a shorter
            # path (or even equal length), move on to the next potential
            # word.
            next if %paths{$joined}:exists and %paths{$joined}.elems ≤ ($checkword<path>.elems + 1);

            %paths{$joined} = [ @($checkword<path>) ];
            %paths{$joined}.push: $joinedcheck;
            my $path = @pending.grep( { $^a<word>.join eq $joinedcheck } );
            if $path.elems == 1 {
                $path[0] = [ @($checkword<path>) ];
                $path[0].push: $joinedcheck;
            } else {
                @pending.push: { word => $potential, path => [] };
                @pending[*-1]<path> = [ @($checkword<path>) ];
                @pending[*-1]<path>.push: $joinedcheck;
            }
        }
    }

    if %paths{$dst}:exists {
        say "Ladder found!";
        say %paths{$dst} ~ " " ~ $dst;
    } else {
        say "No ladder found";
    }
}

sub find_one_off ( @current, @words ) {
    return @words.grep( { notdifferent(@current, $^a) == @current.elems - 1 } );
}

sub notdifferent( @current, @word ) {
    # return (@current Zeq @word).sum; # Slow...
    my $sum = 0;
    for ^@current.elems -> $i {
        $sum++ if @current[$i] eq @word[$i];
    }
    return $sum;
}
