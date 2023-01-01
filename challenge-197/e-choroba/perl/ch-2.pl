#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

use List::Util qw{ max };

# First, find the median. Then distribute elements greater than
# median, median, less than median.
sub wiggle_sort_med(@list) {
    return \@list if 1 >= @list;

    # There are faster ways to find the median, but I had to celebrate
    # the New Year with friends.
    my @s = sort { $a <=> $b } @list;
    my $median_index = int(@s / 2);

    my $gt_median = $median_index;
    ++$gt_median until $gt_median > $#s || $s[$gt_median] > $s[$median_index];

    my $from = $gt_median;
    my $to = 1;
    my @r;
    while ($from <= $#s) {
        $r[$to] = $s[$from++];
        $to += 2;
    }

    $from = $gt_median - 1;
    while ($s[$from] == $s[$median_index] && $to <= $#s) {
        $r[$to] = $s[$from--];
        $to += 2;
    }

    $to = 0;
    while ($s[$from] == $s[$median_index] && $to <= $#s) {
        $r[$to] = $s[$from--];
        die 'No way' if $to < $#r && $r[$to] >= $r[$to + 1];
        $to += 2;
    }

    $from = 0;
    while ($to <= $#s) {
        $r[$to] = $s[$from++];
        $to += 2;
    }
    return \@r
}

# Depth first.
sub wiggle_sort_df(@list) {
    my $m = max(@list);
    my $r = _wiggle_prefix([$m + 1], @list);
    die 'No way' unless $r;

    shift @$r;
    return $r
}

# Breadth first. Very slow and memory hungry.
sub wiggle_sort_bf(@list) {
    my @agenda = ([]);
    while (@{ $agenda[0] } < @list) {
        my @next;
        for my $w (@agenda) {
            for my $l (0 .. $#list) {
                my $size = @$w;
                push @next, [@$w, $l]
                    if 0 == $size
                    || ($list[ $w->[-1] ] <=> $list[$l]) == (1, -1)[ $size % 2 ]
                    && ! grep $_ == $l, @$w;
            }
        }
        @agenda = @next;
        die 'No way' unless @agenda;
    }
    return [@list[ @{ $agenda[0] } ]]
}

sub _wiggle_prefix($prefix, @list) {
    return $prefix unless @list;

    return [@$prefix, @list] if @list == 1 && $list[0] < $prefix->[-1];

    for my $pos1 (0 .. $#list) {
        next if $list[$pos1] >= $prefix->[-1];

        for my $pos2 (0 .. $#list) {
            next if $pos1 == $pos2;

            if ($list[$pos1] < $list[$pos2]) {
                no warnings 'recursion';
                my $r = _wiggle_prefix([@$prefix, @list[$pos1, $pos2]],
                                       @list[ grep $_ != $pos1 && $_ != $pos2,
                                              0 .. $#list ]);
                return $r if $r;
            }
        }
    }
    return
}

use Test2::V0;
plan(3 * (2 * (2 + 6) + 4));

for my $wiggle_sort (*wiggle_sort_med{CODE},
                     *wiggle_sort_df{CODE},
                     *wiggle_sort_bf{CODE}
) {
    local *wiggle_sort = $wiggle_sort;

    for my $array ([1, 5, 1, 1, 6, 4],  # Example 1.
                   [1, 3, 2, 2, 3, 1],  # Example 2.
                   [1, 2, 3, 4, 5],     # Odd number of elements.
                   [1, 1, 1, 2, 2],     # 3 + 2.
                   [1],                 # Single element.
                   [2, 1],              # Two elements.
                   [1, 2, 2, 3],        # Can't start with the first one.
                   [1 .. 11],           # To show time complexity.
    ) {
        my $w = wiggle_sort(@$array);

        my @sa = sort @$array;
        my @sw = sort @$w;
        is \@sa, \@sw, "same elements @$w";

        my $does_wiggle = 1;
        for my $i (1 .. $#$w) {
            undef $does_wiggle
                if ($w->[ $i - 1 ] <=> $w->[$i]) != ($i % 2 ? -1 : 1)
        }
        is $does_wiggle, 1, 'wiggles';
    }

    {   my $e = dies { wiggle_sort(1, 1, 2, 2, 2) };
        like $e, qr/No way/, '2+3';
    }

    {   my $e = dies { wiggle_sort(1, 2, 2, 2) };
        like $e, qr/No way/, '1+3';
    }

    {   my $e = dies { wiggle_sort(1, 1, 1, 2) };
        like $e, qr/No way/, '3+1';
    }

    {   my $e = dies { wiggle_sort(2, 2) };
        like $e, qr/No way/, 'same 2';
    }
}

use Benchmark qw{ cmpthese };

my @l = (1 .. 5, 1 .. 5);
cmpthese(-25, {
    median => sub { wiggle_sort_med(@l) },
    df     => sub { wiggle_sort_df(@l) },
    bf     => sub { wiggle_sort_bf(@l) },
});

@l = (1 .. 50) x 50;
cmpthese(-5, {
    median => sub { wiggle_sort_med(@l) },
    df     => sub { wiggle_sort_df(@l) },
    # bf   => sub { wiggle_sort_bf(@l) },  # OOM.
});

__END__

           Rate        bf        df    median
bf      0.864/s        --     -100%     -100%
df      64595/s  7472329%        --      -66%
median 189000/s 21863777%      193%        --

         Rate     df median
df     3.17/s     --  -100%
median 1242/s 39031%     --
