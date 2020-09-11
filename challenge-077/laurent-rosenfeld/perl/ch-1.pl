use strict;
use warnings;
use feature "say";

# Original task

my $target = shift // 100;
my @fib = (1, 2);
while (1) {
    my $new_fib = $fib[-1] + $fib[-2];
    last if $new_fib >= $target;
    push @fib, $new_fib;
}
my $curr = $target;
my @result;
for my $i (reverse @fib) {
    next if $i > $curr;
    push @result, $i;
    last if $i == $curr;
    $curr -= $i;
}
say "$target ->  @result";
