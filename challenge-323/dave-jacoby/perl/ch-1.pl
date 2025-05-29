#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use List::Util qw{ sum0 };

my @examples = (

    [ "--x", "x++", "x++" ],
    [ "x++", "++x", "x++" ],
    [ "x++", "++x", "--x", "x--" ],
);

for my $example (@examples) {
    my $operations = join ', ', map { qq{"$_"} } $example->@*;
    my $output     = increment_decrement($example->@*);
    say <<"END";
    Input:  \@operations = ($operations)
    Output: $output
END
}

sub increment_decrement (@operations) {
    my $value = 0;
    for my $op ( @operations ) {
        $value ++ if $op =~ /\+\+/mx;
        $value -- if $op =~ /\-\-/mx;
    }
    return $value;
}
