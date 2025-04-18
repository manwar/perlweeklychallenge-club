#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

my @examples = (
    { str1 => "uvw", str2 => "bcudvew" },
    { str1 => "aec", str2 => "abcde" },
    { str1 => "sip", str2 => "javascript" },
);

for my $example (@examples) {
    my $str1   = $example->{str1};
    my $str2   = $example->{str2};
    my $output = subsequence($example);
    say <<"END";
    Input:  \$str1 = "$str1",
            \$str2 = "$str2"
    Output: $output
END
}

sub subsequence ($example) {
    my $i = 0;
    my $s = length $example->{str1};
    for my $j ( 0 .. -1 + length $example->{str2} ) {
        my $l1 = substr $example->{str1}, $i, 1;
        my $l2 = substr $example->{str2}, $j, 1;
        if ( $l1 eq $l2 ) { $i += 1; }
    }
    return $i == $s ? 'true' : 'false';
}
