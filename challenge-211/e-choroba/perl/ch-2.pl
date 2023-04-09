#! /usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ sum };

sub split_same_average_brute_force(@list) {
    my $avg = sum(@list) / @list;
    my @mask = (0) x @list;
    $mask[-1] = 1;
    while (1) {
        my $s = sum(@list[grep $mask[$_], 0 .. $#mask]);
        return 1 if abs($s / (grep $_, @mask) - $avg) < 1e-9;

        my $pos = $#mask;
        while ($mask[$pos]) {
            $mask[$pos] = 0;
            return if --$pos < 1;
        }
        $mask[$pos] = 1;
    }

}

sub split_same_average(@list) {
    my $sum = sum(@list);
    my $avg = $sum / @list;
    my $max_length = (@list + 1) / 2;
    --$max_length if $max_length >= @list - 1;

    my %possible;  # {sum}{length}
    $possible{0}{0} = 1;
    for my $e (@list) {
        # Sort is needed so we don't process the added sum again in
        # the same step.
        for my $s (sort { $b <=> $a } keys %possible) {
            for my $length (keys %{ $possible{$s} }) {
                next if $length == @list - 1;

                $possible{ $s + $e }{ $length + 1 } = 1;
                return 1 if abs(($s + $e) / ($length+1) - $avg) < 1e-9;
            }
        }
    }
    return
}

use Test::More;

ok split_same_average(1, 2, 3, 4, 5, 6, 7, 8), 'Example 1';
ok ! split_same_average(1, 3), 'Example 2';

ok split_same_average(-2, 0, 2), 'Avg 0';
ok split_same_average(1, 5, 5, 1), 'Duplicates';

for (1 .. 200) {
    my @list = map int rand 20, 1 .. 2 + rand 10;
    is split_same_average(@list), split_same_average_brute_force(@list),
        "same @list";
}

my @l = map int rand 50, 1 .. 12;
is split_same_average(@l), split_same_average_brute_force(@l),
        "same @l";
done_testing();

use Benchmark qw{ cmpthese };
cmpthese(-3, {
    brute_force => sub { split_same_average_brute_force(@l) },
    fast        => sub { split_same_average(@l) },
});
