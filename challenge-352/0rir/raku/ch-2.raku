#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

constant \BENCH = True;

=begin comment
May be edited for space.
352-2: Binary Prefix        Submitted by: Mohammad Sajid Anwar
You are given an array, @nums, where each element is either 0 or 1.

Define xi as the number formed by taking the first i+1 bits of @nums (from $nums[0] to $nums[i]) and interpreting them as a binary number, with $nums[0] being the most significant bit.

For example:

If @nums = (1, 0, 1), then:

x0 = 1 (binary 1)
x1 = 2 (binary 10)
x2 = 5 (binary 101)

For each i, check whether xi is divisible by 5.
Write a script to return an array @answer where $answer[i] is true if x<sub>i</sub> is divisible by 5, otherwise false.

=end comment

my @Test = do { 
     my (\F, \T) = False, True;

    # input                         expect
    (0,1,1,0,0,1,0,1,1,1),          (T, F, F, F, F, T, T, F, F, F),
    (1,0,1,0,1,0),                  (F, F, T, T, F, F),
    (0,0,1,0,1),                    (T, T, F, F, T),
    (1,1,1,1,1),                    (F, F, F, T, F),
    (1,0,1,1,0,1,0,0,1,1),          (F, F, T, F, F, T, T, T, F, F),
    ;
}
plan 2 × +@Test ÷ 2;

# I've been playing with strs vs array, here the substr is efficient…
sub task-str( @a is copy, $divr = 5  -->Array) {
    my $in = @a.join;
    my @ret;
    for 1..$in.chars -> \tail {
       @ret.push( $in.substr(0, tail).parse-base(2) %% $divr );
    }
    @ret
}
# … but math is faster than .parse-base.
sub task-mult( @a is copy, $divr = 5  -->Array) {
    my ( $curr, @ret) = 0;
    @ret.push:  ( $curr = $curr × 2 + $_) %% $divr for @a;
    @ret;
}

if BENCH {
    use Bench;
    my $b = Bench.new;

    sub get-inputs( @a, $step = 1 -->Array) {
        return @a  if @a ~~ () or $step == 1;
        warn "Array is not divisable by step" unless @a.elems %% $step;
        return @a[0] if @a.end < $step;
        my $end = 2 × ( @a.end div $step);
        return @a[0, $step … $end].Array
    }
    my @t = get-inputs @Test, 2;

    $b.cmpthese(1000, {

        task-str   => sub { for @t { task-str  $_, 5  } },
        task-mult  => sub { for @t { task-mult $_, 5  } },
    });
}

for @Test -> $in, $exp {
    is task-str( $in), $exp, " $in.join()";
    is task-mult( $in), $exp, " $in.join()";
}
done-testing;

my  @num = (0,1,0,1,0,0,0,0,0,0,0,0,0,0,0);

say qq{\nInput: @num = (@num.join(','))}
  ~ qq{\nOutput: (}, (task-mult( @num)».lc).join( ', '), ')';
