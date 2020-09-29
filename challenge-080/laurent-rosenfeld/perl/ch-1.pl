use strict;
use warnings;
use feature qw /say/;

my @nums = @ARGV > 1 ? @ARGV : (5, 2, -2, 0);
my @sorted = sort { $a <=> $b } grep $_ >= 0, @nums;
die "No solution with given input!" if @sorted < 1;
my $result;
for my $i (0..scalar @nums - 1) {
    $result = ($sorted[$i] + 1) and last
        if $sorted[$i] + 1 < $sorted[$i+1];
}
say $sorted[-1] + 1 and exit unless defined $result;
say  $result ;
