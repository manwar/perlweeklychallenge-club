#| return average of lists.
sub avg(*@list) { (sum @list) / @list.elems; }

#| average of stream at every point.
sub MAIN(*@nums where {$_.all ~~ Int}) {
    put @nums.keys.map({avg @nums[0..$_]});
}
