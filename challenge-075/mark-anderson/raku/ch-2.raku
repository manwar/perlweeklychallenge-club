=begin usage

Usage: raku ch-2.raku 1 2 3 4

Output:

4       #
3     # #
2   # # #
1 # # # #
  - - - -
  1 2 3 4

6: (3 x 2) formed by columns (3, 4)
6: (2 x 3) formed by columns (2, 3, 4)

=end usage

# These subsets ensure that the arguments are Ints and there 
# are at least 2 which are 2 or bigger to form a rectangle.

subset IntArray of Array where .all ~~ Int;

subset MoreThan1IntArray of IntArray where .elems > 1;

subset AtLeast2BiggerThan1 of MoreThan1IntArray where .grep(* > 1).elems >= 2;

unit sub MAIN(*@array where @array ~~ AtLeast2BiggerThan1);

my %h;

for 2..@array.elems -> $i {
    for @array.rotor($i => 1-$i) -> $list { 
        %h{$list} = $list.min * $list.elems;  
    }
}

for @array.max ... 1 -> $i {
    say "$i " ~ do 
    for @array -> $v { 
        if $v >= $i { "#" } else { " " } 
    }
}

printf "%s%s\n%s%s\n\n", " ", " -" x @array.elems, "  ", "{@array}";

for %h.maxpairs -> $pair {
    my @digits = $pair.key.comb(/\d+/);
    say "{$pair.value}: ({@digits.min} x {@digits.elems}) formed by columns ",
    @digits.fmt("%d", ", ").List;
}
