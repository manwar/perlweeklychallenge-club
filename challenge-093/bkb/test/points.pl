#!/home/ben/software/install/bin/perl
use warnings;
use strict;
use utf8;
use FindBin '$Bin';
use JSON::Create;
use JSON::Parse 'parse_json';
use File::Slurper 'write_text';
use IPC::Run3;
use Test::More;

my $binary = "$Bin/../perl/ch1.pl";

my $jc = JSON::Create->new (sort => 1, indent => 1);

# Paolo Custodio

my $paolo1 = ["1 1  2 2  3 4" => {max => 2}];
my $paolo2 = ["1 1  2 2  3 1  1 3  5 3" => {max => 3}];

my $n = 1;
for my $paolo ($paolo1, $paolo2) {
    my $points = $paolo->[0];
    my @n = split /\s+/, $points;
    my @p;
    while (@n) {
	my $p = {};
	$p->{x} = 0 + shift @n;
	$p->{y} = 0 + shift @n;
	push @p, $p;
    }
    run ("paolo-$n", \@p, $paolo->[1]);
    $n++;
}

# Dave Jacoby

my @examples;
push @examples, [ 1, [ [ 1, 1 ], [ 2, 2 ], [ 3, 3 ] ] ];
push @examples, [ 2, [ [ 1, 1 ], [ 2, 2 ], [ 3, 1 ], [ 1, 3 ], [ 5, 3 ] ] ];
push @examples,
    [
    3,
    [ [ 1, 1 ], [ 2, 2 ], [ 3, 1 ], [ 1, 3 ], [ 3, 3 ], [ 4, 4 ], [ 5, 3 ] ]
    ];
push @examples, [ 4, [ [ 1, 2 ], [ 2, 4 ], [ 3, 6 ], [ 4, 8 ] ] ];

# Expected results

my %jx = (
    1 => {max => 3},
    2 => {max => 3},
    3 => {max => 4},
    4 => {max => 4}
);

for my $jacoby (@examples) {
    my $n = $jacoby->[0];
    my @p;
    for my $p (@{$jacoby->[1]}) {
	push @p, {x => $p->[0], y => $p->[1]};
    }
    run ("jacoby-$n", \@p, $jx{$n});
}

# E. Choroba

my @choroba = (
[[[1, 1], [2, 2], [3, 3]], 3, 'Example 1'],
[[[1,1], [2,2], [3,1], [1,3], [5,3]], 3, 'Example 2'],
# The question doesn't really specify whether duplicates are allowed,
# or how to count them if so, so this number is dubious.
# [[[1, 1], [1, 1], [1, 1], [1, 1],
#   [2, 2], [2, 2], [2, 2],
#   [1, 2], [1, 2],
#   [3, 1]],
#  7, 'duplicates'],
[[[2, 2], [3, 2], [4, 2], [5, 2], [5, 3], [6, 7]], 4, 'horizontal'],
[[[2, 2], [2, 3], [2, 4], [2, 5], [5, 3], [6, 7]], 4, 'vertical'],
[[[0, 0], [0, 1], [0, 2],
  [1, 0], [1, 1], [1, 2],
  [2, 0], [2, 1], [2, 2]], 3, '3x3'],
[[[0, 0], [0, 1], [0, 2],
  [1, 0], [1, 1], [1, 2],
  [2, 0], [2, 1], [2, 2],
  [4, 4]], 4, '3x3 diagonal'],
[[[0, 0], [0, 1], [0, 2],
  [1, 0], [1, 1], [1, 2],
  [2, 0], [2, 1], [2, 2],
  [3, 0]], 4, '3x3 horizontal'],
[[[0, 0], [0, 1], [0, 2],
  [1, 0], [1, 1], [1, 2],
  [2, 0], [2, 1], [2, 2],
  [2, 3]], 4, '3x3 vertical'],
);

for my $choroba (@choroba) {
    my @p;
    for (@{$choroba->[0]}) {
	push @p, {x => $_->[0], y => $_->[1]};
    }
    my $name = 'choroba-' . $choroba->[2];
    $name =~ s/\W/-/g;
    run ($name, \@p, {max => $choroba->[1]});
}

done_testing ();
exit;

sub run
{
    my ($name, $input, $expect) = @_;
    my $out = "$Bin/$name.json";
    write_text ($out, $jc->run ($input));
    run3 ("$binary $out", undef, \my $output, \my $errors);
    unlink $out or die $!;
    if ($errors) {
	diag ("Errors from $binary: $errors");
	return;
    }
    my $results = parse_json ($output);
    cmp_ok ($results->{max}, '==', $expect->{max}, "$name count same");
}
