use strict;
use warnings;
use Test::More;

sub find_missing_members {
    my ($arr1_ref, $arr2_ref) = @_;
    my %count;

    $count{$_}++ for @$arr1_ref;
    $count{$_}-- for @$arr2_ref;

    my @missing_in_arr2 = sort { $a <=> $b } grep { $count{$_} > 0 } keys %count;
    my @missing_in_arr1 = sort { $a <=> $b } grep { $count{$_} < 0 } keys %count;

    return (\@missing_in_arr2, \@missing_in_arr1);
}

# Testing
my @test1_arr1 = (1, 2, 3);
my @test1_arr2 = (2, 4, 6);
my ($result1, $result2) = find_missing_members(\@test1_arr1, \@test1_arr2);
is_deeply($result1, [1, 3], 'Test 1 - Missing in arr2');
is_deeply($result2, [4, 6], 'Test 1 - Missing in arr1');

done_testing();
