#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures };

my @examples = (    # added a couple test entries

    [ [ 2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5 ], [ 2, 1, 4, 3, 5, 6 ], ],
    [ [ 3, 3, 4, 6, 2, 4, 2, 1, 3 ],       [ 1, 3, 2 ], ],
    [ [ 3, 0, 5, 0, 2, 1, 4, 1, 1 ],       [ 1, 0, 3, 2 ], ]
);

for my $example (@examples) {
    my $list1  = join ', ', $example->[0]->@*;
    my $list2  = join ', ', $example->[1]->@*;
    my $output = join ', ', relative_sort($example) ;
    say <<"END";
    Input:  \@list1 = ($list1)
            \@list2 = ($list2)
    Output: ($output)
END
}

sub relative_sort ($input) {
    my @list1 = $input->[0]->@*;
    my @list2 = $input->[1]->@*;
    my @output;
    for my $d (@list2) {
        push @output, grep { $_ == $d } @list1;
        @list1 = grep { $_ != $d } @list1;
    }
    return @output, sort @list1;
}
