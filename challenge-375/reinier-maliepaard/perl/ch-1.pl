#!/usr/bin/perl
use strict;
use warnings;

sub single_common_word {
    my ($arr1_ref, $arr2_ref) = @_;

    for ($arr1_ref, $arr2_ref) {
        die "argument should be an array reference"
            unless ref($_) eq 'ARRAY';
    }

    # Hashes storing frequency counts
    my (%count1, %count2);

    # Count occurrences in @arr1
    $count1{$_}++ for @$arr1_ref;

    # Count occurrences in @arr2
    $count2{$_}++ for @$arr2_ref;

    my $res = 0;

    # Iterate over UNIQUE keys from first array
    for my $key (keys %count1) {

        $res++
            if $count1{$key} == 1
            && defined $count2{$key}
            && $count2{$key} == 1;
    }

    return $res;
}


my (@arr1, @arr2);

# TESTS

my $str;

# Example 1
@arr1 = ("apple", "banana", "cherry");
@arr2 = ("banana", "cherry", "date");
print single_common_word(\@arr1, \@arr2), "\n";   # Output: 2

# Example 2
@arr1 = ("a", "ab", "abc");
@arr2 = ("a", "a", "ab", "abc");
print single_common_word(\@arr1, \@arr2), "\n";   # Output: 2

# Example 3
@arr1 = ("orange", "lemon");
@arr2 = ("grape", "melon");
print single_common_word(\@arr1, \@arr2), "\n";   # Output: 0

# Example 4
@arr1 = ("test", "test", "demo");
@arr2 = ("test", "demo", "demo");
print single_common_word(\@arr1, \@arr2), "\n";   # Output: 0

# Example 5
@arr1 = ("Hello", "world");
@arr2 = ("hello", "world");
print single_common_word(\@arr1, \@arr2), "\n";   # Output: 1
