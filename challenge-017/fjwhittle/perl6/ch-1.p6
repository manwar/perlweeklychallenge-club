#!/usr/bin/env perl6

my subset Positive of Int where * > 0;

# Ackerman function definitions
multi A(0, Positive $n)           { $n + 1                   }
multi A(Positive $m, 0)           { A($m - 1, 1)             }
multi A(Positive $m, Positive $n) { A($m - 1, A($m, $n - 1)) }

#| Print resulting Ackerman Number with <m> and <n>
unit sub MAIN ($m = 1, $n = 2);

# Anonymous cache handler.
&A.wrap: -> $m, $n { .[$m;$n] //= callsame } given Array.new;

say A($m, $n);

