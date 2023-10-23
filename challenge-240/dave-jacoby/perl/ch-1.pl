#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @examples = (

    { str => [ "Perl", "Python", "Pascal" ], chk => "ppp", },
    { str => [ "Perl", "Raku" ],             chk => "rp", },
    { str => [ "Oracle", "Awk", "C" ],       chk => "oac", },
);

for my $e (@examples) {
    my $output = acronym($e);
    my $str   = join ', ', map { qq{"$_"} } $e->{str}->@*;
    my $chk    = $e->{chk};
    say <<~"END";
    Input:  \@str = ($str)
            \$chk = "$chk"
    Output: $output
    END
}

sub acronym ($input) {
    my $work = lc join '', map { substr $_, 0, 1 } $input->{str}->@*;
    return $work eq $input->{chk} ? 'true' : 'false' ;
}
