use strict;
use warnings;
use feature 'say';

sub can_build_target {
    my ($source_ref, $target_ref) = @_;

    my $target_string = join('', @$target_ref);

    my $source_count = scalar @$source_ref;
    my %used_source_indices = ();
    my @used_order = ();

    while (length $target_string) {
        my $match_found_in_cycle = 0;

        for my $i (0 .. $source_count - 1) {
            next if exists $used_source_indices{$i};

            my $sub_array_ref = $source_ref->[$i];
            my $source_pattern = join('', @$sub_array_ref);

            if ($target_string =~ s/^\Q$source_pattern\E//) {
                $used_source_indices{$i} = 1;
                push @used_order, $sub_array_ref;
                $match_found_in_cycle = 1;
                last;
            }
        }

        unless ($match_found_in_cycle) {
            return (0, []);
        }
    }

    return (1, \@used_order);
}

sub format_array_of_arrays {
    my $arr_ref = shift;
    return "(" . (join ', ', map { "[" . (join ',', @$_) . "]" } @$arr_ref) . ")";
}
sub format_array {
    my $arr_ref = shift;
    return "(" . (join ', ', @$arr_ref) . ")";
}


# Example 1
my @source1 = ([2, 3], [1], [4]);
my @target1 = (1, 2, 3, 4);

my ($result1, $order_ref1) = can_build_target(\@source1, \@target1);
my @order1 = @$order_ref1;

say "Input: \@source = " . format_array_of_arrays(\@source1);
say "Input: \@target = " . format_array(\@target1);
say "Output: " . ($result1 ? 'true' : 'false');

if ($result1) {
    say "Use in the order: " . format_array_of_arrays(\@order1);
}
say "\n";

# Example 2
my @source2 = ([1,3], [2,4]);
my @target2 = (1, 2, 3, 4);

my ($result2, $order_ref2) = can_build_target(\@source2, \@target2);
my @order2 = @$order_ref2;

say "Input: \@source = " . format_array_of_arrays(\@source2);
say "Input: \@target = " . format_array(\@target2);
say "Output: " . ($result2 ? 'true' : 'false');

if ($result2) {
    say "Use in the order: " . format_array_of_arrays(\@order2);
}
say "\n";

# Example 3
my @source3 = ([9,1], [5,8], [2]);
my @target3 = (5, 8, 2, 9, 1);

my ($result3, $order_ref3) = can_build_target(\@source3, \@target3);
my @order3 = @$order_ref3;

say "Input: \@source = " . format_array_of_arrays(\@source3);
say "Input: \@target = " . format_array(\@target3);
say "Output: " . ($result3 ? 'true' : 'false');

if ($result3) {
    say "Use in the order: " . format_array_of_arrays(\@order1);
}
say "\n";

# Example 4
my @source4 = ([1], [3]);
my @target4 = (1, 2, 3);

my ($result4, $order_ref4) = can_build_target(\@source4, \@target4);
my @order4 = @$order_ref4;

say "Input: \@source = " . format_array_of_arrays(\@source4);
say "Input: \@target = " . format_array(\@target4);
say "Output: " . ($result4 ? 'true' : 'false');

if ($result4) {
    say "Use in the order: " . format_array_of_arrays(\@order4);
}
say "\n";

# Example 5
my @source5 = ([7, 4, 6]);
my @target5 = (7, 4, 6);

my ($result5, $order_ref5) = can_build_target(\@source5, \@target5);
my @order5 = @$order_ref5;

say "Input: \@source = " . format_array_of_arrays(\@source5);
say "Input: \@target = " . format_array(\@target5);
say "Output: " . ($result5 ? 'true' : 'false');

if ($result5) {
    say "Use in the order: " . format_array_of_arrays(\@order5);
}

