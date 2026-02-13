#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
357-2: Task 2: Unique Fraction Generator
Submitted by: Yary

Given a positive integer N, generate all unique fractions you can create using integers from 1 to N and follow the rules below:

- Use numbers 1 through N only (no zero)
- Create fractions like numerator/denominator
- List them in ascending order (from smallest to largest)
- If two fractions have the same value (like 1/2 and 2/4),
  only show the one with the smallest numerator
=end comment

my @Test =
    # in        exp
    1, ( < 1/1>,),
    2, < 1/2 1/1 2/1 >,
    3, < 1/3 1/2 2/3 1/1 3/2 2/1 3/1>,
    4, < 1/4 1/3 1/2 2/3 3/4 1/1 4/3 3/2 2/1 3/1 4/1>,
    6, < 1/6 1/5 1/4 1/3 2/5 1/2 3/5 2/3 3/4
            4/5 5/6 1/1 6/5 5/4 4/3 3/2 5/3 2/1
                5/2 3/1 4/1 5/1 6/1>,
    5, < 1/5 1/4 1/3 2/5 1/2 3/5 2/3 3/4 4/5 1/1
        5/4 4/3 3/2 5/3 2/1 5/2 3/1 4/1 5/1>,
;
plan +@Test ÷ 2;

my \OOB = <-1/2>;

multi task( Any:D(Int) $a where * == 1 ) { "1/1" }
multi task( Any:D(Int) $a where * > 1 ) {
    my $prev = OOB;
                # generate in partial order
    my @ret = hyper do for ( (1...$a) X ($a...1)).map(
                               { RatStr.new( .[0]/.[1], .[0] ~ '/' ~ .[1]) }
                            ).sort() -> \rs
    {
        next if rs == $prev;
        $prev = rs;
        rs.Str;
    }
}

for @Test -> $in, @exp {
    is task( $in), @exp, "{@exp // @exp.^name()} <- $in.raku()";
}

done-testing;

my $int = 100;
say qq{\nInput: \$int = $int\nOutput: }, task( $int).join(', ');
