use strict;
use warnings;
use feature 'say';

sub generate_string {
    my $n = shift;
    return "" if $n == 0;
    return "0" if $n == 1;
    my $s_n_1 = generate_string($n - 1);
    my $reversed_switched = join "", map { $_ eq '0' ? '1' : '0' } reverse split //, $s_n_1;
    return $s_n_1 . "0" . $reversed_switched;
}

say generate_string(30);

