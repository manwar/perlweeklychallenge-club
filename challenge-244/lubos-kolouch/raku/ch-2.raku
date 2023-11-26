sub group-hero-power(@nums) {
    return [+] @nums.elems.map: -> $i {
        @nums.combinations($i).map: { .max**2 * .min }.sum
    }
}

# Tests
use Test;
plan 1;
is group-hero-power(2, 1, 4), 141, 'Test Case 1';
