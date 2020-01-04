# Write a script to display first 20 Leonardo Numbers. Please checkout wiki
# page for more information.
#
# For example:
# L(0) = 1
# L(1) = 1
# L(2) = L(0) + L(1) + 1 = 3
# L(3) = L(1) + L(2) + 1 = 5
#
# and so on.

# Define a lazy fibonacci sequence.
constant @fib = 0, 1, * + * ... *;

# Leonardo numbers are related to Fibonacci numbers as
#   leonardo(n + 1) = 2 * fib(n) + 1
sub leonardo(Int $n) {
    if ($n == 0) {
        1;
    } else {
        2 * @fib[$n - 1] + 1;
    }
}

say "First 20 Leonardo numbers:";
for ^20 -> $n {
    leonardo($n).say;
}
