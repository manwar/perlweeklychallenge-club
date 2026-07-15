#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

my @examples = (
    { in => 32, out => 1 },
    { in => 15, out => 0 },
    { in => 34, out => 1 },
);

is validate_circle($_->{in}), $_->{out} foreach @examples;

done_testing;

sub validate_circle {
    my ($n) = @_;

    my @solutions = gen_all_circles($n);

    return 0 if @solutions == 0;

    my $is_square = sub {
        my $num = shift;
        return 0 if $num < 0;

        my $root = int(sqrt($num));
        return $root * $root == $num;
    };

    foreach my $sol_ref (@solutions) {
        my @arr = @$sol_ref;

        next if @arr != $n;

        my %seen;
        my $has_dup = 0;
        for my $num (@arr) {
            if ($num < 1 || $num > $n || $seen{$num}++) {
                $has_dup = 1;
                last;
            }
        }
        next if $has_dup;

        my $valid_sums = 1;
        for my $i (0 .. $n - 1) {
            my $current = $arr[$i];
            my $next    = $arr[($i + 1) % $n];
            unless ($is_square->($current + $next)) {
                $valid_sums = 0;
                last;
            }
        }

        return 1 if $valid_sums;
    }

    return 0;
}

sub gen_all_circles {
    my $n = shift;

    my %squares = map { $_*$_ => 1 } 1 .. int(sqrt(2*$n));

    my @all_solutions;
    my @path = (1);
    my @used;
    $used[1] = 1;

    my $dfs;
    $dfs = sub {
        if (@path == $n) {
            if ($squares{$path[-1] + $path[0]}) {
                push @all_solutions, [@path];
            }
            return;
        }

        for my $next (2 .. $n) {
            next if $used[$next] || !$squares{$path[-1] + $next};

            $used[$next] = 1;
            push @path, $next;

            $dfs->();

            $used[$next] = 0;
            pop @path;
        }
    };

    $dfs->();
    return @all_solutions;
}
