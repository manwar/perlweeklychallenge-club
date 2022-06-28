#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

use Ref::Util qw{ is_plain_coderef };

sub compose ($f, $g) {
    is_plain_coderef($_) or die "Not a CODE reference!"
        for $f, $g;
    return sub ($x) { $f->($g->($x)) }
}

use Test::More tests => 1;

my $f = sub ($x) { $x * 2 };
my $g = sub ($x) { $x + 2 };
my $h = compose($f, $g);

is $h->(10), 24;
