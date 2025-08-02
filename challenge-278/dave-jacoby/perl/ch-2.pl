#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc say postderef signatures state };

use List::Util qw{ first };

my @examples = (

    { str => "challenge",   char => "e" },
    { str => "programming", char => "a" },
    { str => "champion",    char => "b" },
);

for my $input (@examples) {
    my $output = reverse_word($input);
    my $str   = $input->{str};
    my $char  = $input->{char};

    say <<"END";
        Input:  \$str = "$str", \$char = "$char"
        Output: "$output"
END
}

sub reverse_word ($obj) {
    my $str   = $obj->{str};
    my $char  = $obj->{char};
    my $first = first { substr( $str, $_, 1 ) eq $char } 0 .. length $str;
    return $str unless defined $first;
    my $to_sort = substr( $str, 0, $first + 1 );
    my $sorted = join '', sort split //, substr( $str, 0, $first + 1 );
    substr($str,0,$first+1) = $sorted;
    return $str;
}
