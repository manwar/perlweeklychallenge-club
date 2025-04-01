#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use List::Util qw{ uniq };

my @examples = (

    [qw{perl perrrl}],
    [qw{raku rrakuuuu}],
    [qw{python perl}],
    [qw{coffeescript cofffeescccript}],
);

for my $example (@examples) {
    my ( $name, $typed ) = $example->@*;
    my $output = broken_keys( $example->@* );
    say <<"END";
    Input:  \$name = "$name", \$typed = "$typed"
    Output: $output
END
}

sub broken_keys(@words) {
    my ( $intended, $actual ) = @words;
    my $ii = no_repeats($intended);
    my $aa = no_repeats($actual);
    return 'false' unless $ii eq $aa;
    return 'true';
}

sub no_repeats ($word) {
    my @word = uniq sort split //, $word;
    for my $l (@word) {
        $word =~ s/${l}+/$l/gmx;
    }
    return $word;
}
