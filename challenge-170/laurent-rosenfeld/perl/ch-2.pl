use strict;
use warnings;
use feature "say";

sub print_matrix {
    for my $row (@_) {
        print map sprintf(" %3d ", $_), @$row;
        say "";
    }
}
sub cross_prod {
    my @c = @{$_[0]};
    my @d = @{$_[1]};
    my @cross_res;
    for my $i (@c) {
        push @cross_res, $i * $_ for @d;
    }
    return [ @cross_res ]
}
sub kroneck_prod {
    my @a = @{$_[0]};
    my @b = @{$_[1]};
    my @result;
    for my $row_a (@a) {
        for my $row_b (@b) {
            push @result, cross_prod $row_a, $row_b;
        }
    }
    print_matrix @result;
}
say "Test 1:";
my @a = ([1, 2], [3, 4]);
my @b = ([5, 6], [7, 8]);
kroneck_prod \@a, \@b;
say "\nTest 2:";
my @c = ([1, 2, 3], [2, 3, 4]);
my @d = ([5, 6], [7, 8], [9, 10]);
kroneck_prod \@c, \@d;
say "\nTest 3:";
kroneck_prod \@d, \@c;
