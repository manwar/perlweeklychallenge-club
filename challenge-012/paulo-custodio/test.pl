#!/usr/bin/perl

use strict;
use warnings;
use 5.030;
use Test::More;

is capture("perl perl/ch-1.pl"), "30031\n";

is capture("perl perl/ch-2.pl /          ".
                            " /a/b/c/d   ".
                            " /a/b/cd    ".
                            " /a/b/cc    ".
                            " /a/b/c/d/e "), "/a/b\n";

is capture("perl perl/ch-2.pl :          ".
                            " :a:b:c:d   ".
                            " :a:b:cd    ".
                            " :a:b:cc    ".
                            " :a:b:c:d:e "), ":a:b\n";

is capture("perl perl/ch-2.pl /          ".
                            " /b/c/d     ".
                            " /a/b/c/d   ".
                            " /a/b/cd    ".
                            " /a/b/cc    ".
                            " /a/b/c/d/e "), "\n";

done_testing;


sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \r\t]*\n/\n/g;
    return $out;
}
