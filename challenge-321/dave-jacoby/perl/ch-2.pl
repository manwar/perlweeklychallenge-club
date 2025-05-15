#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use List::Util qw{ sum0 };

my @examples = (

    {
        str1 => "ab#c",
        str2 => "ad#c"
    },
    {
        str1 => "ab##",
        str2 => "a#b#"
    },
    {
        str1 => "a#b",
        str2 => "c"
    },
);

for my $example (@examples) {
    my $output = backspace_compare( $example );
    say <<"END";
    Input:  \$str1 = "$example->{str1}"
            \$str2 = "$example->{str2}"
    Output: $output
END
}

sub backspace_compare ($obj) {
    my $str1 = $obj->{str1};
    my $str2 = $obj->{str2};
    my $back1 = remove_backspaces($str1);
    my $back2 = remove_backspaces($str2);
    return $back1 eq $back2 ? 'true' : 'false';
}

sub remove_backspaces ( $str ) {
    while ( $str =~ /\w\#/mx ){
        $str =~ s/(\w\#)//mx;
    }
    return $str;
}