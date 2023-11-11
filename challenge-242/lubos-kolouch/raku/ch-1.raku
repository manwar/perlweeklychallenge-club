use Test;

sub find-missing-members(@arr1, @arr2) {
    my %count;

    %count{$_}++ for @arr1;
    %count{$_}-- for @arr2;

    my @missing-in-arr2 = %count.keys.grep({ %count{$_} > 0 }).sort;
    my @missing-in-arr1 = %count.keys.grep({ %count{$_} < 0 }).sort;

    return @missing-in-arr2, @missing-in-arr1;
}

# Testing
my @test1-arr1 = 1, 2, 3;
my @test1-arr2 = 2, 4, 6;
my ($result1, $result2) = find-missing-members(@test1-arr1, @test1-arr2);
is-deeply($result1, ["1", "3"], 'Test 1 - Missing in arr2');
is-deeply($result2, ["4", "6"], 'Test 1 - Missing in arr1');

done-testing();
