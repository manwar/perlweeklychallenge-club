#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
305-2: Alien Dictionary         Submitted by: Mohammad Sajid Anwar
You are given a list of words and alien dictionary character order.

Write a script to sort lexicographically the given list of words based
on the alien dictionary characters.

Example 1
Input: @words = ("perl", "python", "raku")
       @alien = qw/h l a b y d e f g i r k m n o p q j s t u v w x c z/
Output: ("raku", "python", "perl")
Example 2
Input: @words = ("the", "weekly", "challenge")
       @alien = qw/c o r l d a b t e f g h i j k m n p q s w u v x y z/
Output: ("challenge", "the", "weekly")
=end comment

=begin comment
    What is a word is vague.
=end comment

my %alien =
    rev =>[qw{a b c d e f g h i j k l m n o p q r s t u v w x y z}.reverse],
    hla => qw/h l a b y d e f g i r k m n o p q j s t u v w x c z/,
    cor => qw/c o r l d a b t e f g h i j k m n p q s w u v x y z/,
;

my @Test =
    {   words => (),        alien => 'cor',
        exp   => (),
        exp-i => (),
    },
    {   words => ("perl", "python", "raku"),            alien => 'hla',
        exp   => ("raku", "python", "perl"),
        exp-i => ("raku", "python", "perl"),
    },
    {   words => ("the", "weekly", "challenge"),        alien => 'cor',
        exp   => ("challenge", "the", "weekly"),
        exp-i => ("challenge", "the", "weekly"),
    },
    {   words => ("the-", "wee-kly", "cha-lle/n+ge"),   alien => 'cor',
        exp   => ("cha-lle/n+ge", "the-", "wee-kly"),
        exp-i => ("cha-lle/n+ge", "the-", "wee-kly"),
    },
    {   words => ("the", "The"),            alien => 'cor',
        exp   => ("The", "the"),
        exp-i => ("the", "The"),                        # stability
    },
    {   words => ("The", "the"),            alien => 'cor',
        exp   => ("The", "the"),
        exp-i => ("The", "the"),
    },
    {   words => ("city", "Rocks"),         alien => 'cor',
        exp   => ("Rocks", "city"),
        exp-i => ("city", "Rocks"),
    },
    {   words => ("tee", "tHe"),            alien => 'cor',
        exp   => ("tHe", "tee"),
        exp-i => ("tee", "tHe"),
    },
    {   words => ("teEa", "tee"),           alien => 'cor',
        exp   => ("teEa", "tee"),
        exp-i => ("tee", "teEa"),
    },
;
plan @Test × 2;

constant \native = (' '… '~').List;

# Make a Map for sorting using alien alphabets; a not-ascii map
# ignoring control chars.
only mk-map( List $alien --> Map ) {
    ( ( (' '…'@'), @$alien».uc, ( '['… '`'), @$alien, ( '{' … '~') ).flat
        [Z=>]
    ( ' ' … '~')).Map;
}

# Build, and register, known alien alphabet maps.
my %Reg = %alien;
for %Reg.keys -> \k {   %Reg{k} = %Reg{k}.&mk-map; }

my %Map;    # The current mapping in use.
            # XXX!  Eliminate by making intermediate func's which
            # wrap task()'s return statements: @word.&alien-sort-i( %map);

# Sort a list of words with a re-ordered alphabet. :i for ignore case.
sub task( @word, $name, Bool :$i) {
    my @w = @word;
    %Map = %Reg{$name}    // die qq{No alphabet named "$name"};
    return @word.sort: &alien-cmp-i if $i;
    return @word.sort: &alien-cmp;
}

sub alien-cmp( $a, $b -->Order) {
    %Map{$a.comb}.join cmp %Map{$b.comb}.join;
}

sub alien-cmp-i( $a, $b -->Order) {
    %Map{$a.comb».fc}.join cmp %Map{$b.comb».fc}.join;
}

for @Test -> %t {
    is task( %t<words>, %t<alien>    ), %t<exp>,   "%t<exp>   <-= %t<words>";
    is task( %t<words>, %t<alien>, :i), %t<exp-i>, "%t<exp-i> <i= %t<words>";
}
done-testing;

my @word ="The", "weEkly", "chalLenge", "No.150";
my @alien = %alien<rev>;
say "\nInput: @word = (@word[])\n\@alien: (@alien[])"
  ~ "\nOutput: ", task(@word, 'rev', );
