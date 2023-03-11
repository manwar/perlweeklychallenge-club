#!/usr/bin/perl -s

use v5.16;
use warnings;
use experimental 'signatures';

our $letters;

die <<EOS unless @ARGV && $letters;
usage: $0 -letters=LETTERS [FILE]

-letters=LETTERS
    list of letters

FILE
    Name of a file containing one word per line. Use '-' for STDIN.

EOS


### Input and Output

main: {
    my %letters;
    $letters{$_}++ for split //, lc $letters;
    while (<>) {
        chomp;
        say if check_word(\%letters, lc);
    }
}

### Implementation

sub check_word ($letters, $word) {
    my %letters = %$letters;
    for my $l (split //, $word) {
        return unless exists $letters{$l} && $letters{$l}--;
    }
    1;
}
