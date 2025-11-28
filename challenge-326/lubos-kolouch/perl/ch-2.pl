#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);

=head1 DESCRIPTION

Decompressed List (Weekly Challenge 326)

Given an even-length array where each adjacent pair (i, j) indicates
value j repeated i times, return the decompressed list.

=cut

sub decompress_list (@ints) {
    my @out;
    for (my $i = 0; $i < @ints; $i += 2) {
        my ($count, $value) = @ints[$i, $i + 1];
        push @out, ($value) x $count;
    }
    return \@out;
}

if (!caller) {
    require Test::More;
    Test::More::is_deeply( decompress_list(1,3,2,4), [3,4,4], 'Example 1' );
    Test::More::is_deeply( decompress_list(1,1,2,2), [1,2,2], 'Example 2' );
    Test::More::is_deeply( decompress_list(3,1,3,2), [1,1,1,2,2,2], 'Example 3' );
    Test::More::done_testing();
}
