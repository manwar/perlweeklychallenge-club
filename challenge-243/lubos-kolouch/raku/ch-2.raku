use Test;

sub floor-sum(@nums) {
    return [+] do for @nums -> $i {
        map { ($i / $_).Int }, @nums
    }
}

# Tests
is floor-sum(2, 5, 9), 10, 'Test Example 1';
is floor-sum(7, 7, 7, 7, 7, 7, 7), 49, 'Test Example 2';

done-testing;
