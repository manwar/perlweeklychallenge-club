#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

sub generate {
    return join "", map +('(', ')')[rand 2], 1 .. int rand 80
}

sub is_valid {
    my ($s) = @_;
    $s =~ s/\(\)//g while -1 != index $s, '()';
    return ! length $s
}


use Test::More tests => 4;
ok(is_valid('()'));
ok(is_valid('(())'));
ok(! is_valid(')('));
ok(! is_valid('())()'));

my $s = generate();
say $s, ' ', is_valid($s) ? "" : 'in', 'valid';
