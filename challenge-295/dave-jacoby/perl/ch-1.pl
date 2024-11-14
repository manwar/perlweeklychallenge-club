#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

my @examples = (

    { str => 'weeklychallenge',  words => [ "challenge", "weekly" ] },
    { str => "perlrakuperl",     words => [ "raku",      "perl" ] },
    { str => "sonsanddaughters", words => [ "sons", "sand", "daughters" ] },
);

for my $example (@examples) {
    my $output = word_break($example);
    my $str    = $example->{str};
    my $words  = join ', ', map { qq{"$_"} } $example->{words}->@*;
    say <<"END";
    Input:  \$str   = $str,
            \@words = ($words)
    Output: $output
END
}

sub word_break ($object) {
    my $str   = $object->{str};
    my @words = $object->{words}->@*;
    for my $word (@words) {
        if ( $str =~ /$word/ ) { $str =~ s/$word//; }
        else                   { return 'false' }
    }
    return 'true';
}
