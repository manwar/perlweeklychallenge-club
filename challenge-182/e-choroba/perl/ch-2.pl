#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

sub common_path (@paths) {
    my $prefix = shift @paths;
    $prefix =~ s{(?<!/)$}{/};
    for my $path (@paths) {
        $path =~ s{(?<!/)$}{/};
        while (1 < length $path) {
            last if -1 != index $prefix, $path;

            $path =~ s{[^/]+/$}{};
        }
        $prefix = $path;
        last if '/' eq $prefix;
    }
    return substr $prefix, 0, -1
}

use Test::More tests => 5;

is common_path(qw( /a/b/c/1/x.pl
                   /a/b/c/d/e/2/x.pl
                   /a/b/c/d/3/x.pl
                   /a/b/c/4/x.pl
                   /a/b/c/d/5/x.pl
             )),
    '/a/b/c', 'Example';

is common_path(qw( /abc/def/1.pl
                   /abc/de/2.pl
             )),
    '/abc', 'Prefix boundary not on /';

is common_path(qw( /abc/def/ghi/1.pl
                   /abcx/def/ghi/2.pl
             )),
    '', 'Empty';

is common_path(qw( /abc/def
                   /abc/def/
             )),
    '/abc/def', 'Difference in the final slash';

is common_path(qw( /abc/def
                   /abc/def
             )),
    '/abc/def', 'Same';
