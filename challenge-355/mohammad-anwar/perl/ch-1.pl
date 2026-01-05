#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

my %examples = (
    123     => "123",
    1234    => "1,234",
    1000000 => "1,000,000",
    1       => "1",
    12345   => "12,345"
);

is thousand_separator($_), $examples{$_} for keys %examples;

done_testing;

sub thousand_separator {
    my ($num) = @_;

    $num =  reverse $num;
    $num =~ s/(\d{3})(?=\d)/$1,/g;
    return reverse $num
}
