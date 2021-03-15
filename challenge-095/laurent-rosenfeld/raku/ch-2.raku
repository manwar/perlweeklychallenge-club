use v6;

sub put-in-stack (@stack, *@new-items) {
    push @stack, |@new-items;
}
sub take-from-stack (@stack where @stack.elems > 0) {
    return pop @stack;
}
sub top (@stack where @stack.elems > 0) {
    return @stack.tail;
}
sub minimum (@stack where @stack.elems > 0) {
    return @stack.min;
}
my @a-stack = 1..5;
say @a-stack;
put-in-stack @a-stack, 6..8;
say @a-stack;
say "Min: ", minimum @a-stack;
say "Top: ", top @a-stack;
say "Take: ", take-from-stack @a-stack;
say @a-stack;
