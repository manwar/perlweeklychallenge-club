#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab
use v6.d;
use lib $?FILE.IO.parent(2).add('lib');

# Task 2: Pangrams, a sentence or phrase that uses every letter.
# Create a pangram using attached dictionary.


my constant $A-Z-SIZE = 26;
my @best-pg;                       # best pangram found/made
my $best-size;

# Input words sorted by length decreasing.  A bad idea, except
# to fail quickly if there are no pangrams available.

my constant @data =
     $?FILE.IO.parent(1).add("dictionary.txt").lines(:chomp).sort:
     { $^b.chars <=> $^a.chars };

my constant %alpha = map { $_ => True }, ('a'..'z')[0 .. $A-Z-SIZE -1 ];

my $head = @data.end;
my $tail = $head;

my @first-pangram;
my %need = %alpha;

while $tail ≥ 0  {
    my @char = @data[$tail].comb;
    if  @char.any ~~ (map *.key, %need).any {
        for @char -> $k { %need{$k}:delete; }
        @first-pangram.push: @data[ $tail ];
    }
    last if %need ~~ Empty;
    -- $tail;
}

if not is-pangram @first-pangram { say "no pangrams"; exit; }

say "Found: ", @first-pangram;

set-best( improve-pangram( @first-pangram) );

say "Improved: ", @best-pg;

exit;


sub is-pangram( @a -->Bool)  { $A-Z-SIZE == @a.join.comb.unique.elems; }

sub set-best( @pangram ) {
    @best-pg = @pangram;
    $best-size = @pangram.join.chars;
}

sub check-set-best( @pangram --> Bool) {
   if  @pangram.join.chars < $best-size  {
        set-best( @pangram);
        if $best-size == $A-Z-SIZE {
            say 'We found a perfect pangram: >', @best-pg,'<';
            exit;
        }
        return True;
    }
    False;
}

sub improve-pangram( @pangram --> Array ) {
    my @best-opt;
    my @pg = @best-opt = @pangram;

    my $idx = 0;
    while $idx ≤ @pg.end {
        my @candi = @pg[ flat(0..^$idx, $idx^..@pg.end) ];
        if is-pangram( @candi) {
            @pg = @candi;
            @best-opt = @candi if @candi.join.chars < @best-opt.join.chars;
            next;
        } else {
            ++$idx;
        }
    }
    return @best-opt;
}
