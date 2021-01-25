#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use 5.030;

is capture("perl perl/ch-1.pl binary"), <<END;
Guest 10 gets 6.2816% of the pie.
END

is capture("perl perl/ch-2.pl 1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2"), "1\n";
is capture("perl perl/ch-2.pl 3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy"), "1\n";

is capture("perl perl/ch-2.pl 2BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2"), "0\n";
is capture("perl perl/ch-2.pl 4J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy"), "0\n";

is capture("perl perl/ch-2.pl 1lvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2"), "0\n";
is capture("perl perl/ch-2.pl 3O98t1WpEZ73CNmQviecrnyiWrnqRhWNLy"), "0\n";


done_testing;

sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \t\v\f\r]*\n/\n/g;
    return $out;
}
