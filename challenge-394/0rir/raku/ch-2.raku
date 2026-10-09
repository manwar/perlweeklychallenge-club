#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
394-2: Alternating Vowels Consonants    Submitted by: Mohammad Sajid Anwar

You are given three strings containing English alphabetic characters.
Find all the longest contiguous substrings common to all three strings
that strictly alternate between vowels and consonants.
=end comment

my @Test =
    # in                                          exp
    ("relocate", "delocate", "allocate"),         ("locate",),
    ("apple", "banana", "cherry"),                (),
    ("navigate", "cavity", "gravity"),            ("avi",),
    ("pedalgia", "pedalboard", "pedantic"),       ("peda",),
    ("schoolmaster", "schoolhouse", "schooling"), ("ho", "ol"),

    ("apple", "apple"),                           ("ap", "le",),
    ("apple", "grappled"),                        ("ap", "le",),
;
plan @Test ÷ 2;

my regex valid  { ^ [ [ [ <-[aeiou]>   <[aeiou]> ]+ <-[aeiou]>? ]
                    | [ [  <[aeiou]>  <-[aeiou]> ]+  <[aeiou]>? ] ] $
}

multi task( List $l where +* > 1 -->List) {
    my @ret;
    my @word   = $l.sort: *.chars;
    my $small  = @word.pop;
    my @valid = ( ( $small ~~ m:ex/ .+/ )».Str).unique
                .grep( { / <valid> / })
                .sort( *.chars).reverse;
    for ^@valid -> \i {
        my $current = @valid[i];
        if @word.all.contains( $current ) {
            if !@ret  or  @ret.head.chars == $current.chars {
                @ret.push: $current;
                next;
            }
            last;
        }
    }
    @ret.List;
}

for @Test -> @in, @exp, {
    is task( @in).sort, @exp.sort, "{@exp // @exp.^name()} <- @in.raku()";
}
done-testing;

my @str = "magellan", "mage", "magestic";
say qq{\nInput: @str = ("@str.join(", ")")\nOutput: ("},
        task(@str).join( '", "'), '")';
