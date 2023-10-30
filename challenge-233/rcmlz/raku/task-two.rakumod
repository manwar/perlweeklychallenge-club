unit module challenge-nr233::rcmlz::raku::task-two:ver<0.0.1>:auth<rcmlz@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/rcmlz/raku/ test/challenge-nr233/raku/task-two.rakutest

#|[
You are given an array of integers.

- Write a script to sort the given array in increasing order based on the frequency of the values.
- If multiple values have the same frequency then sort them in decreasing order.
]
our sub solution(@input) is export {
    @input.Bag
          .sort( { order($^a, $^b) } )
          .map(  { listify($_) } )
          .flat
}

sub order($a, $b --> Order){
    my Order $c = $a.value cmp $b.value;
    $c eq Same ?? $b.key cmp $a.key !! $c
}

sub listify(Pair $pair --> Seq){
    ($pair.key x $pair.value).comb( $pair.key.Str.comb.elems )
}