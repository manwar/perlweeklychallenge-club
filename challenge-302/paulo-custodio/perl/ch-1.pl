#!/usr/bin/env perl

use Modern::Perl;

my @str = split ' ', <>;
my($x, $y) = split ' ', <>;
say find_largest_subset($x, $y, @str);

sub find_largest_subset {
    my($x, $y, @str) = @_;
    my $largest_size = 0;

    my $find_largest_subset;
    $find_largest_subset = sub {
        my($prefix, $pending) = @_;

        # check if prefix is a valid subset
        my $prefix_str = join '', @$prefix;
        my $num_zeros = $prefix_str =~ tr/0/0/;
        my $num_ones  = $prefix_str =~ tr/1/1/;
        if ($num_zeros <= $x && $num_ones <= $y) {
            my $subset_size = scalar(@$prefix);
            $largest_size = $subset_size if $largest_size < $subset_size;
        }

        if (@$pending == 0) {
            return;
        }
        else {
            for my $i (0 .. $#$pending) {
                my @new_prefix = (@$prefix, $pending->[$i]);
                my @new_pending = @$pending;
                splice(@new_pending, $i, 1);
                $find_largest_subset->(\@new_prefix, \@new_pending);
            }
        }
    };
    $find_largest_subset->([], \@str);
    return $largest_size;
}
