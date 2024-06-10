#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ bitwise fc postderef say signatures state };

use List::Util qw{max};

my @examples = (

    { str => "perl",      char => "e" },
    { str => "java",      char => "a" },
    { str => "python",    char => "m" },
    { str => "ada",       char => "a" },
    { str => "ballerina", char => "l" },
    { str => "analitik",  char => "k" },
);
for my $example (@examples) {
    my $char    = $example->{char};
    my $str     = $example->{str};
    my @str     = split //, $str;
    my $count   = scalar grep { $_ eq $char } @str;
    my $total   = scalar @str;
    my $output  = round( 100 * $count / $total );
    say <<"END";
Input:  \$str = "$str", \$char = "$char"
Output: "$output"
END
}

sub round ($number) {
    my $int = int $number;
    return $number if $number == $int;
    my $r = $number - $int;
    return $r < 0.5 ? $int : $int + 1;
}
