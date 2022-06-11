use Modern::Perl;
use List::Util qw<reductions>;

say join ', ', reductions { $a + $b }
            1, reductions { $a * $b } 1..9;

# Output: 1, 2, 4, 10, 34, 154, 874, 5914, 46234, 409114
