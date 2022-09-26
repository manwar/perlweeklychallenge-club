#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub sequence_number ($list) {
    die "Not enough digit combinations.\n" if @$list > 100;
    my $i = 0;
    return [map s/^../sprintf '%02d', $i++/re, @$list];
}

use Test2::V0;
plan 4;

is sequence_number(['ab1234', 'cd5678', 'ef1342']),
    ['001234', '015678', '021342'],
    'Example 1';

is sequence_number(['pq1122', 'rs3334']),
    ['001122', '013334'],
    'Example 2';

my $seq1 = sequence_number(generate_ids(100));
is $seq1->[-1], '991234', 'Last possible element';

my $exception = dies { sequence_number(generate_ids(101)) };
like $exception, qr/Not enough digit combinations/, 'Too long';

no warnings 'experimental';  # Turned off by Test2::V0.
sub generate_ids ($size) {
    my $id = 'aa';
    return [map $id++ . '1234', 1 .. $size]
}
