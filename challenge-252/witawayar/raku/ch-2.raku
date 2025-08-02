my &fun = { list -$_ .. $_ given $^n div 2 }

#`{
- Take a scalar via the implicit signature $^n
- Floor-divide it by 2, and the range between minus that and itself satisfies the condition
}

use Test;
my @tests of UInt = 5, 3, 1;

for @tests -> $n {
    ok fun($n).sum == 0;
    LAST done-testing;
}
