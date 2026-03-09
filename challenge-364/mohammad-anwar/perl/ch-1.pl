#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

my %examples = (
    "10#11#12"  => "jkab",
    "1326#"     => "acz",
    "25#24#123" => "yxabc",
    "20#5"      => "te",
    "1910#26#"  => "aijz",
);

is decrypt_string($_), $examples{$_} for keys %examples;

done_testing;

sub decrypt_string {
    my $str = shift;

    $str =~ s/(\d{2})#|(\d)/ chr(($1 || $2) + 96) /ge;
    return $str;
}
