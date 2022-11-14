my %map = (1..26 Z 'A'..'Z').flat;
my @result;
# say %map; # {1 => A, 10 => J, 11 => K, 12 => L,...

sub decode (@list, $out) {
    if @list.elems == 0 {
        push @result, $out;
        return;
    }
    if @list[0] != 0 {
        decode @list[1..@list.end], $out ~ %map{@list[0]};
        return if @list.elems == 1;
        if @list[0] == 1 or (@list[0] == 2 and @list[1] <= 6) {
            decode @list[2..@list.end], $out ~ %map{@list[0] ~ @list[1]};
        }
    }
}

for 11, 1115, 5115, 127, 1207 -> $num {
    my @digits = $num.comb;
    @result = ();
    decode @digits, "";
    say "$num \t -> ", join ", ", sort @result;
}
