#!/usr/bin/perl

use strict;
use warnings;
use 5.030;
use Test::More;

is capture("perl perl/ch-1.pl"), "2.71828182845905\n";

is capture('perl perl/ch-2.pl http://example.com/foo%2a'),
                             'http://example.com/foo%2A'."\n";
is capture('perl perl/ch-2.pl HTTP://User@Example.COM/Foo'),
                             'http://User@example.com/Foo'."\n";
is capture('perl perl/ch-2.pl HTTP://Example.COM/Foo'),
                             'http://example.com/Foo'."\n";
is capture('perl perl/ch-2.pl http://example.com/%7Efoo%2ebar'),
                             'http://example.com/~foo.bar'."\n";
is capture('perl perl/ch-2.pl http://example.com/foo/./bar/baz/../qux'),
                             'http://example.com/foo/bar/qux'."\n";
is capture('perl perl/ch-2.pl http://example.com'),
                             'http://example.com/'."\n";
is capture('perl perl/ch-2.pl http://example.com:80/'),
                             'http://example.com/'."\n";

done_testing;


sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \r\t]*\n/\n/g;
    return $out;
}
