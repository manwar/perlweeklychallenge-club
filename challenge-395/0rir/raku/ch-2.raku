#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment

May be edited for no good reason:
395-2: Word Squares        Submitted by: Mohammad Sajid Anwar
You are given a list of equal lengths words.
Write a script to arrange a set of words into a grid that reading across any row gives the exact same word as reading down its corresponding column.

=end comment

my @Test =
      ("MA", "AM", "MY", "ME"),
                  ("MA", "AM"),
     ("SUN", "USE", "NET", "SEE", "TEN"),
                 ("SUN", "USE", "NET"),
     ("BOAT", "TEAL", "AREA", "TSAR", "OGRE"),
                 ("BOAT", "OGRE", "AREA", "TEAL"),
     ("CARD", "AREA", "REAR", "DART"), 
                 ("CARD", "AREA", "REAR", "DART"),
    ("HEART", "TREND", "EMBER", "RESIN", "ABUSE",),
                ("HEART", "EMBER", "ABUSE", "RESIN","TREND"),
      ("MA", "MY", "ME"),
                  (),
;
plan @Test ÷ 2;

sub task( @ary where { 1 < .[0].chars == .all.chars ≤ .elems } --> List) {

    my $els = @ary[0].chars;
    my @perm =  @ary.permutations».Array; 

    # collect indices for upper-right scant half of the squares
    my @idx; 
    my $r  = 0;
    while $r < $els {
        my $c = $r +1;
        while $c < $els {
            @idx.push: [$r,$c] unless $r == $c;
            ++$c;
        }
        ++$r;
    }
        # Look for the mirroring half
    A-COMB: for @perm -> @cur {
    @cur = @cur[^$els];  # Trim the permutation to square.
    @cur.=map: *.comb;
#say '@cur is  ', @cur.raku; exit;

        for @idx -> @i {
#say "@i @i[]";
#say "candi  @cur.raku() ";
            when @cur[@i[0];@i[1]] !~~ @cur[@i[1];@i[0]] {
                next A-COMB;
            }
            when  @i ~~ @idx.tail {
                return (@cur».join).List;
            }
        }
    }
    return ();
}

for @Test -> @in, @exp {
    is task( @in), @exp, "{@exp // @exp.^name()} <- @in.raku()"
}

done-testing;

my  @word = "HEART", "TREND", "EMBER", "RESIN", "ABUSE";

# String a list with preface, joiners, suffix. The default is:
#  <a b c> »> "a", "b", "c"
sub list-wrap( @a, :$head='"', :$inner='", "', :$tail='"') { 
    $head ~ @a.join($inner) ~ $tail;
}

say "\nInput: @word = (\"", @word.&list-wrap, ")\n"
    ~ "Output: (", task( @word).&list-wrap, ")\n"

