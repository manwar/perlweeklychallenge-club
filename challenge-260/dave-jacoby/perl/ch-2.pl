#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use Algorithm::Permute;
use List::Util qw{ first uniq };

my @examples = (qw{ CAT GOOGLE SECRET });

for my $example (@examples) {
    my $output = dictionary_rank($example);

    say <<"END";
    Input: \$word = '$example'
    Output: $output
END
}

sub dictionary_rank ($word) {
    my @word = split //, $word;
    my @list;
    my $iter = Algorithm::Permute->new( \@word );
    while ( my @p = $iter->next ) {
        push @list, join '', @p;
    }
    @list = uniq sort @list;

    # would normally worry about a not-there response, but
    # since the permutations are based on the word, the word
    # has to be in there.
    my $i = first { $word eq $list[$_] } 0 .. scalar @list;
    return $i + 1;
}
