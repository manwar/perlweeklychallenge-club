use strict;
use warnings;
use feature "say";

my @matrix = ([ 0, 0, 'X'], [ 'X', 0, 0], [ 'X', 0, 0 ]);

@matrix = ([ qw<O O X O> ],
          [ qw<X O O O> ],
          [ qw<X O O X> ],
          [ qw<O X O O> ]);

# @matrix = ([qw <X X X>], [0, 0, 0]);

sub check {
    my ($m, $k) = @_;
    for my $i (-1, 0, 1) {
        for my $j (-1, 0, 1) {
            next if $i == 0 and $j == 0;
            next if $m+$i < 0 or $k+$j < 0;
            next unless exists $matrix[$m+$i] and exists $matrix[$m+$i][$k+$j];
            return 0 if $matrix[$m+$i][$k+$j] eq 'X';
        }
    }
    return 1;
}

my @result;
for my $i (0..$#{$matrix[0]}) {
    for my $j (0..$#matrix) {
        next unless $matrix[$j][$i] eq 'X';
        push @result, [$j, $i] if check $j, $i;
    }
}
say "@$_" for  @result;
say 0 unless @result;
