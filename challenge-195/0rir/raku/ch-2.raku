#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ «␤»
use v6.d;
use Test;

=begin comment
195-2: Most Frequent Even       Submitted by: Mohammad S Anwar

Given a list of numbers, @list, find the most frequent even numbers in the
list. In case you get more than one even number then return the smallest
even integer. For all other case, return -1.

Example 1
Input: @list = (1,1,2,6,2)
Output: 2 as there are only 2 even numbers 2 and 6 and of those 2 appears the most.
Example 2
Input: @list = (1,3,5,7)
Output: -1 since no even numbers found in the list
Example 3
Input: @list = (6,4,4,6,1)
Output: 4 since there are only two even numbers 4 and 6. They both appears the equal number of times, so pick the smallest.
=end comment

sub most-freqy-even( @l where * !~~ () --> Int) {
    my %h = Bag.new( @l.grep( * %% 2));
    %h = grep { .key == %h.keys.min}, %h.grep( { .value ~~ %h.values.max});
    return (Int) if %h ~~ {};
    %h.keys[0].Int;
}

multi MAIN ( 'test' ) {
    my @Die = { in => (),  exp => (Int),   }, ;

    my @Test =
        { in => (1,1,2,2,6,6),      exp => 2,       },
        { in => (1,1,2,6,2),        exp => 2,       },
        { in => (1,3,5,7),          exp => (Int),   },
        { in => (6,4,4,6,1),        exp => 4,       },
        { in => (6,6,6,6,6),        exp => 6,       },
        { in => (1,2,3,4,5),        exp => 2,       },
        { in => (2,2,3,3,6,6),      exp => 2,       },
    ;
    plan +@Test + @Die;
    for @Die  -> %t {
        dies-ok { most-freqy-even( @(%t<in>))},
                "most-freqy-even("~  (%t<exp>//"(Int)")  ~") dies.";
   }
   for @Test -> %t {
        quietly is most-freqy-even( @(%t<in>) ), %t<exp>,
            (%t<exp> // '(Int)')  ~" <- %t<in>";
    }
    done-testing;
}

multi MAIN() {
    my @list = (1,2,2,2,2,2,3,6,6,6,6,6);
    say "Input: \@list = @list.join(', ');\nOutput: ",
            &most-freqy-even(@list) // -1;
}
