use strict;
use warnings;
use feature qw/say/;

sub pretty_print {
    my $matrix_ref = shift;
    for my $rows (@$matrix_ref) {
        say join " ", @$rows;
    }
}

my $size = shift() - 1;
my @matrix;
for my $i (0..$size) {
        $matrix[$i][$_] = $i == $_ ? 1 : 0 for 0..$size;
}
pretty_print \@matrix;
