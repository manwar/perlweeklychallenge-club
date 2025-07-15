use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($string) {
    my @result;
    while ($string =~ /(\S+)/g) {
        push @result, lc($1);
        $result[-1] = ucfirst($result[-1]) if length($result[-1]) > 2;
    }
    return join(" ", @result);
}

is(run("PERL IS gREAT"), "Perl is Great", "Example 1");
is(run("THE weekly challenge"), "The Weekly Challenge", "Example 2");
is(run("YoU ARE A stAR"), "You Are a Star", "Example 3");
