#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

my @examples = (
    {
        words    => [ "cat", "bat", "rat" ],
        sentence => "the cattle was rattle by the battery",
    },
    {
        words    => [ "a", "b", "c" ],
        sentence => "aab aac and cac bab",
    },
    {
        words    => [ "man", "bike" ],
        sentence => "the manager was hit by a biker",
    },
    {
        words    => [qw{ ca ma p }],
        sentence => 'a man, a plan, a canal: panama',
    }
);

for my $example (@examples) {
    my $output   = replace_words($example);
    my $words    = join ', ', map { qq{"$_} } $example->{words}->@*;
    my $sentence = $example->{sentence};

    say <<"END";
    Input:  \@words = ($words)
            \$sentence = "$sentence"
    Output: "$output"
END
}

sub replace_words($object) {
    my @words    = $object->{words}->@*;
    my $sentence = $object->{sentence};
    for my $word (@words) {
        if ( $sentence =~ /\W$word/mx ) {
            $sentence =~ s/(\b$word\w+\b)/$word/gmx;
        }
    }
    return $sentence;
}
