sub is-magic (Int $n is copy) {
    my @numbers = <zero one two three four five six seven eight nine>;
    my $output = "";
    loop {
        my $letter-count = @numbers[$n].chars;
        if $n == 4 {
            return $output ~ "four is magic.";
        } else {
            $output ~= "@numbers[$n] is @numbers[$letter-count], ";
            $n = $letter-count;
        }
    }
}
for 1..9 -> $n {
  say "$n: ", is-magic($n).tc;
}
