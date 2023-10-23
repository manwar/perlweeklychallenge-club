use strict;
use warnings;
use Test::More;

sub create_new_array {
    my @old = @_;
    my @new;

    for my $i (0..$#old) {
        push @new, $old[$old[$i]];
    }

    return @new;
}

is_deeply([create_new_array(0, 2, 1, 5, 3, 4)], [0, 1, 2, 4, 5, 3], 'Test Case 1');
is_deeply([create_new_array(5, 0, 1, 2, 3, 4)], [4, 5, 0, 1, 2, 3], 'Test Case 2');

done_testing();
