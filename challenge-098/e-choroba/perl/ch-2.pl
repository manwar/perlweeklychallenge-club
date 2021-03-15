#!/usr/bin/perl
use warnings;
use strict;

=head1 Search Insert Position

For larger arrays, binary search is much faster.

=cut

sub loop {
    my ($array, $value) = @_;
    my $i = 0;
    ++$i until $i > $#$array || $array->[$i] >= $value;

    splice @$array, $i, 0, $value
        unless $i <= $#$array && $array->[$i] == $value;
    return $i
}

sub binary_search {
    my ($array, $value) = @_;
    my ($from, $to) = (0, $#$array);
    while ($from != $to) {
        my $middle = int(($from + $to) / 2);
        if (($array->[$middle] // $value) >= $value) {
            $to = $middle;
        } else {
            $from = $from == $middle ? $to : $middle;
        }
    }
    ++$from if @$array && $value > $array->[-1];

    splice @$array, $from, 0, $value
        unless $from <= $#$array && $array->[$from] == $value;
    return $from
}

use Test::More tests => 60;

sub test {
    my ($value, $before, $after, $index, $name) = @_;
    my $before_clone = [@$before];
    is loop($before, $value), $index, "$name index loop";
    is binary_search($before_clone, $value), $index, "$name index binary";
    is_deeply $before, $after, "$name array loop";
    is_deeply $before_clone, $after, "$name array binary";
}

test(3, [1, 2, 3, 4], [1, 2, 3, 4], 2, 'Example 1');
test(6, [1, 3, 5, 7], [1, 3, 5, 6, 7], 3, 'Example 2');
test(10, [12, 14, 16, 18], [10, 12, 14, 16, 18], 0, 'Example 3');
test(19, [11, 13, 15, 17], [11, 13, 15, 17, 19], 4, 'Example 4');

test(1, [1 .. 10], [1 .. 10], 0, 'Find start');
test(10, [1 .. 10], [1 .. 10], 9, 'Find end');
test(1, [], [1], 0, 'Empty');
test(3, [3], [3], 0, 'Find single');
test(1, [2], [1, 2], 0, 'Prepend single');
test(3, [2], [2, 3], 1, 'Append single');
test(1, [1, 2], [1, 2], 0, 'Find pair left');
test(2, [1, 2], [1, 2], 1, 'Find pair right');
test(2, [1, 3], [1, 2, 3], 1, 'Insert pair');
test(0, [1, 2], [0, 1, 2], 0, 'Prepend pair');
test(3, [1, 2], [1, 2, 3], 2, 'Append pair');

use Benchmark qw{ cmpthese };
cmpthese(-3, {
    loop   => sub { loop(         my $arr = [1 .. 1000], 500) },
    binary => sub { binary_search(my $arr = [1 .. 1000], 500) },
});
