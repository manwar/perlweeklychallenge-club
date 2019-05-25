unit module ModuleCH02;

=begin pod

=head1 Rankings

=item B«Standard Ranking (1224)»: Items that compare equal receive the same
    ranking number, and then a gap is left right after any set of equal-ranking
    items.

For instance, let (A, B, C, D) be a group of scores where A is ranked above 
any other item, B and C compare equal and D follows the items comparing equal.

"A", which ranks above any other items, receives ranking number 1. Then, B
and C receive the following ranking number, 2. Because D follows a group of
equal-ranking items, it receives the ranking number after the gap at 3. 
Thus, D is ranked fourth (4).

Therefore, we have the ranking 1224.

=item B«Modified Ranking (1334)»: Items that compare equal receive the same
    ranking number however, unlike standard ranking, a gap is left right before
    any set of equal-ranking items.

"A", which ranks above any other items, receives ranking number 1. Then, B
and C receive the following ranking number. However, their ranking number 
is one plus the gap at 2. Thus, they receive the ranking number 3. D receives
the ranking number 4.

Therefore, we have the ranking 1334.

=item B«Dense Ranking (1223)»: Items that compare equally receive the same
    ranking number, and the next item(s) receive the immediately following
    ranking number.

"A", which ranks above any other items, receives ranking number 1. Then, B and
C receive the immediately following ranking number, 2. Same for D, 
which receives the ranking number 3.

Therefore, we have the ranking 1223.

=head1 Subroutines
=end pod

=begin comment
Challenge 009#2:
Write a script to perform the different types of ranking described above.
=end comment

proto ranking( *@items where *.elems > 0, | ) is export { * }

#| Perform standard competition ranking with given @items.
multi ranking( *@items --> Array ) {
    my Int:D @rankings = 1;

    for 1..@items.end -> $i {
        @rankings[$i] = do 
            if @items[$i] cmp @items[$i-1] == Same { @rankings[$i - 1] }
            else { $i + 1 }
    }
    return @rankings;
}

#| Perform modified competition ranking with given @items.
multi ranking( *@items, :$modified! --> Array ) {
    my Int:D @rankings = 1;

    for 1..@items.end -> $i {
        @rankings[$i] = do 
            if @items[$i] cmp @items[$i-1] === Same {
                @rankings[$i-1]
            }
            elsif @items[$i-2] and
                  @items[$i-1] cmp @items[$i-2] === Same and
                  @items[$i] ≠ (@items[$i-1], @items[$i-2]).all
            {
                @rankings[$i-1] + 1
            }
            else {
                @rankings[$i-1] + 2
            }
    }
    return @rankings;
}

#| Perform dense competition ranking with given @items.
multi ranking( *@items, :$dense! --> Array ) {
    my Int:D @rankings = 1;

    for 1..@items.end -> $i {
        @rankings[$i] = do 
            if @items[$i] cmp @items[$i-1] === Same { @rankings[$i - 1] }
            else { @rankings.tail + 1 }
    }
    return @rankings;
}
