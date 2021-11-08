use strict;
use warnings;
use feature "say";

sub mid_three {
    my $in = abs $_[0];
    my $length = length $in;
    return "Even number of digits" unless $length % 2;
    return "Too short" if $length < 3;
    my $mid_point = ($length - 1) /2;
    return substr($in, $mid_point - 1, 3);
}
for my $n (qw<1234567 -123 1 10 -54321>) {
    say "$n -> ", mid_three $n;
}
