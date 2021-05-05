#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say state postderef signatures };
no warnings qw{ experimental };

my @words = get_words();

for my $word (@words) {
    state $c = 0;
    my $sort = sort_word($word);
    if ( $sort eq $word ) {
        say $word;
        last if $c++ > 5;
    }
}

sub get_words {
    my $dict = '/usr/share/dict/words';
    my @words;
    if ( -f $dict && open my $fh, '<', $dict ) {
        @words =
            sort { length $b <=> length $a }
            grep { length $_ > 1 }
            map  { chomp $_; lc $_ } <$fh>;
    }
    return @words;
}

sub sort_word ( $word ) {
    return join '', sort split //, $word;
}
