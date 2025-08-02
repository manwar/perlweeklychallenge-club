#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

my @examples = (

    {
        array => [ "Perl", "Weekly", "Challenge" ],
        word  => "PWC",
    },
    {
        array => [ "Bob", "Charlie", "Joe" ],
        word  => "BCJ",
    },
    {
        array => [ "Morning", "Good" ],
        word  => "MM",
    },
);

for my $example (@examples) {
    my $array  = join ', ', map { qq{"$_"} } $example->{array}->@*;
    my $word   = $example->{word};
    my $output = acronyms($example);
    say <<"END";
    Input:  \@array = ($array)
            \$word  = "$word"
    Output: $output
END
}

sub acronyms ($example) {
    my @array   = $example->{array}->@*;
    my $word    = $example->{word};
    my $acronym = join '', map { substr $_, 0, 1 } $example->{array}->@*;
    return $word eq $acronym ? 'true' : 'false';
}
