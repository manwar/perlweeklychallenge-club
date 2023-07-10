#! /usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub special_notes($source, $target) {
    for my $char (split //, $target) {
        return unless $source =~ s/$char//;
    }
    return 1
}

sub special_notes_optimised($source, $target) {
    my %count;
    ++$count{$_} for split //, $source;
    $count{$_}-- || return for split //, $target;
    return 1
}

use Test::More tests => 2 * 3 + 1;

for my $special_notes (\&special_notes,
                       \&special_notes_optimised
) {
    ok ! $special_notes->('abc', 'xyz'), 'Example 1';
    ok $special_notes->('scriptinglanguage', 'perl'), 'Example 2';
    ok $special_notes->('aabbcc', 'abc'), 'Example 3';
}

use Benchmark qw{ cmpthese };
my $source = 'pythonicrubylikescriptinglanguage';
my $target = 'perlrubypython';

is  special_notes($source, $target),
    special_notes_optimised($source, $target),
    'same';
cmpthese(-3, {
    regex => sub { special_notes($source, $target) },
    opt   => sub { special_notes_optimised($source, $target) },
});
