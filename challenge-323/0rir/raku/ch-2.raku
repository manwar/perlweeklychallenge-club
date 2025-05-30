#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
323-2: Tax Amount       Submitted by: Mohammad Sajid Anwar
You are given an income amount and tax brackets.
Write a script to calculate the total tax amount.

Example 1
Input: $income = 10, @tax = ([3, 50], [7, 10], [12,25])
Output: 2.65

1st tax bracket upto  3, tax is 50%.
2nd tax bracket upto  7, tax is 10%.
3rd tax bracket upto 12, tax is 25%.

Total Tax => (3 * 50/100) + (4 * 10/100) + (3 * 25/100)
          => 1.50 + 0.40 + 0.75
          => 2.65

Example 2
Input: $income = 2, @tax = ([1, 0], [4, 25], [5,50])
Output: 0.25

Total Tax => (1 * 0/100) + (1 * 25/100)
          => 0 + 0.25
          => 0.25

Example 3
Input: $income = 0, @tax = ([2, 50])
Output: 0
=end comment

my @Test =
    # income    tax-sched                       exp
    #            [bracket-end, tax-rate]
    [ 10,   ( [3,50], [7,10], [12,25],),        2.65, ],
    [  2,   ( [1, 0], [4 , 25], [5 , 50],),     0.25, ],
    [  0,   ([2, 50],),                         0,    ],
;
plan +@Test;

# characteristics of a tax bracket
enum Bracket< LOWER UPPER RATE TX-BASE TX-IN TX-MAX>;

# Cache and stack the brackets so only one bracket need be in tax calculation.
sub create-brackets( @sch -->Tax-schedule) {
    my $idx = ^@sch;
    my @ret = @sch.Array.deepmap({$_});

    for @$idx -> \i {
        @ret[i][RATE] = @sch[i][1] ÷ 100;
        @ret[i][UPPER] = @sch[i][0];

        @ret[i][LOWER] = i == $idx.min ?? 0 !! @ret[i-1][UPPER];
             # tax for whole span of bracket
        @ret[i][TX-IN] = ( @ret[i][UPPER] - @ret[i][LOWER]) × @ret[i][RATE];
             # tax for all lower brackets
        @ret[i][TX-BASE] = i == $idx.min ??  0
                                        !! @ret[i-1][TX-BASE] +@ret[i-1][TX-IN];
                # total tax at top of bracket
        @ret[i][TX-MAX] = i == $idx.min ?? @ret[i][TX-IN]
                                       !! @ret[i-1][TX-MAX] + @ret[i][TX-IN];
    }
    if @ret[*-1][UPPER] < ∞ {
                # create a bracket for income above highest given bracket 
        @ret.push: [ @ret[*-1][UPPER], ∞, 0, @ret[*-1][TX-MAX]];
    }
        # delete unneeded elements
    @ret.=map: {.[LOWER,UPPER,RATE,TX-BASE] };
}

sub task( $income, @tax-sched -->Rat) {
    # make applicable tax schedule
   my @sch= create-brackets( @tax-sched);
   my $i = 0;
   ++$i while $income > @sch[$i][UPPER];
   @sch[$i][TX-BASE] + ($income - @sch[$i][LOWER]) × @sch[$i][RATE]
}

for @Test -> @data {
    for @data -> $income, @sched, $exp {
        is task($income, @sched), $exp,
            "{$exp // $exp.^name()} <- $income ∘∘ @sched.raku()";
    }
}
done-testing;

my $income = 10; 
my @tax = ([3, 50], [7, 10], [12,25]);

say qq{\nInput: \$income = $income, @tax = @tax.raku()\nOutput: }, task($income, @tax);
say qq{@tax = @tax.raku()};
