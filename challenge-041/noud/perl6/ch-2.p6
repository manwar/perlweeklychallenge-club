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

# Leonard numbers are related to Fibonacci numbers as
#   leonard(n) = 2 * fib(n) + 1
sub leonard(Int $n) {
    2 * @fib[$n] + 1;
}

say "Leonard numbers 0 to 20:";
for 0..20 -> $n {
    leonard($n).say;
}
