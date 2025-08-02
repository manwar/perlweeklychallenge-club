#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ bitwise fc postderef say signatures state };

use List::Util qw{max};

my @examples = (

    {
        words1 => [ "Perl", "is",  "my",   "friend" ],
        words2 => [ "Perl", "and", "Raku", "are", "friend" ],
    },
    {
        words1 => [ "Perl",   "and", "Python", "are", "very",  "similar" ],
        words2 => [ "Python", "is",  "top",    "in",  "guest", "languages" ],
    },
    {
        words1 => [ "Perl", "is", "imperative", "Lisp", "is", "functional" ],
        words2 => [ "Crystal", "is", "similar", "to",   "Ruby" ],
    },
);

for my $example (@examples) {
    my $output = common_count($example);
    my $words1 = join '", "', $example->{words1}->@*;
    my $words2 = join '", "', $example->{words2}->@*;
    say <<"END";
    Input:  \@words1 = ("$words1"), 
            \@words2 = ("$words2")
    Output: $output
END
}

sub common_count ($input) {
    my @words1 = $input->{words1}->@*;
    my @words2 = $input->{words2}->@*;
    my $hash;
    map { $hash->{$_}{1}++; $hash->{$_}{2} //= 0 } @words1;
    map { $hash->{$_}{2}++; $hash->{$_}{1} //= 0 } @words2;
    return scalar grep { $hash->{$_}{1} == 1 && $hash->{$_}{2} == 1 }
        keys $hash->%*;
}
