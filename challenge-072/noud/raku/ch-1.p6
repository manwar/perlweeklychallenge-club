# You are given a positive integer $N (<= 10).
#
# Write a script to print number of trailing zeroes in $N!.
# Example 1
# Input: $N = 10
# Output: 2 as $N! = 3628800 has 2 trailing zeroes
#
# Example 2
# Input: $N = 7
# Output: 1 as $N! = 5040 has 1 trailing zero
#
# Example 3
# Input: $N = 4
# Output: 0 as $N! = 24 has 0 trailing zero

# The only thing you have to do is count the prime factors 2 * 5 in the
# factorial. Because half of the natural numbers are even there will be plenty
# factors of 2 in the factorial. Hence the only thing we need to count are the
# prime factors of 5. We have an extra factor of 5 when n is:
#   5, 10, 15, 20, 25, ...
# Then we get another factor of 5 when n is:
#   25, 50, 75, 100, 125, ...
# Another with each multiple of 5^3, etc. Thefore the number of factors of 5
# in n factorial is:
#   floor(n / 5) + floor(n / 5^2) + floor(n / 5^3) + ...

sub trailing-zeros($n) {
    [+] (floor($n / 5**$_) for 1..floor($n**(1/5) + 1));
}

trailing-zeros(125).say;
trailing-zeros(25).say;
trailing-zeros(10).say;
trailing-zeros(7).say;
trailing-zeros(4).say;
