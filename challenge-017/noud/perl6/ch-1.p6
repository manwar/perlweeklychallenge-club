# Create a script to demonstrate Ackermann function. The Ackermann function is
# defined as below, m and n are positive number:
#
#          A(m, n) = n + 1                  if m = 0
#          A(m, n) = A(m - 1, 1)            if m > 0 and n = 0
#          A(m, n) = A(m - 1, A(m, n - 1))  if m > 0 and n > 0
#
# Example expansions as shown in wiki page.
#
#         A(1, 2) = A(0, A(1, 1))
#                 = A(0, A(0, A(1, 0)))
#                 = A(0, A(0, A(0, 1)))
#                 = A(0, A(0, 2))
#                 = A(0, 3)
#                 = 4

multi A(0, Int $n) { $n + 1 };
multi A(Int $m, 0) { A($m - 1, 1) };
multi A(Int $m, Int $n) { A($m - 1, A($m, $n - 1)) };


multi MAIN('test') {
    use Test;

    # As is known, the Ackerman function grows fast. Hence we only test the
    # Ackermann function for some small values.
    is A(1, 2), 4;
    is A(1, 1), 3;
    is A(2, 2), 7;
    is A(3, 3), 61;
}
