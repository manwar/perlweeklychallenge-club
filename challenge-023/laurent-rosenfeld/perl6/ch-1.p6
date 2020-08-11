use v6;

sub fwd-diff (*@in) {
    map {$_[1] - $_[0]},  (@in).rotor(2 => -1)
}
sub MAIN (Int $order, *@values) {
    if @values.elems <= $order {
        die "Can't compute {$order}th series of {@values.elems} values";
    }
    my @result = @values;
    for 1 .. $order {
        @result = fwd-diff @result;
    }
    say "{$order}th forward diff of @values[] is: @result[]";
}
