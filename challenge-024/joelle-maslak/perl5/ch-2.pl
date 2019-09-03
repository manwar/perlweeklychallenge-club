#!/usr/bin/env perl

use v5.16;  # for fc
use strict;
use warnings;

use File::ByLine;
use List::Util qw(uniq);

# Using file by line means that a very long single file might be able to
# be processed quicker (assuming IO can keep up).

MAIN: {
    my %docs;

    my $fbl = File::ByLine->new();
    $fbl->processes(10);

    for my $fn (uniq @ARGV) {
        # Read the file, seperate out the words (use File::ByLine to
        # allow 10 threads to simultaniously read the file)
        #
        # F::BL->map applies the map to each line.
        my %found;
        $docs{$fn} = [
            uniq $fbl->map(
                sub {
                    grep { $_ ne '' and exists $found{$_} ? undef : ($found{$_} = 1) }
                        map   { fc }    # Case insensitive words
                        split /\W+/, $_
                },
                $fn,
            )
        ];
    }

    # Build the index
    my %index;
    for my $fn (sort keys %docs) {
        for my $word ($docs{$fn}->@*) {
            $index{$word} = [] unless exists $index{$word};
            push $index{$word}->@*, $fn;
        }
    }

    # Output the index
    for my $word (sort keys %index) {
        say "$word: " . join(" ", $index{$word}->@*);
    }
}


