#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ bitwise fc postderef say signatures state };

use List::Util qw{max};

my @examples = (

 "1.1.1.1", "255.101.1.0"
);
for my $example (@examples) {
    my $output = defang_ipv4($example);
    say <<"END";
    Input:  \$ip = "$example"
    Output: "$output"
END
}

sub defang_ipv4 ( $address ) {
    $address =~ s/\./[.]/gmx;
    return $address;
}
