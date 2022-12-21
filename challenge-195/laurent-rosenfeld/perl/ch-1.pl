use strict;
use warnings;
use feature qw/say/;

sub is_special {
    my $n = shift;
    # return True if length $n == 1;
    my %h = map { $_ => 1} split //, $n;
    return scalar %h == length $n;
}

for my $m (15, 32..45, 1232, 1233, 1234) {
    my $count = $m <= 9 ? $m : 9;
    for my $i (10..$m) {
        $count++ if is_special $i;
    }
    say "$m \t -> $count";
}
