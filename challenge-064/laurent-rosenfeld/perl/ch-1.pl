use strict;
use warnings;
use feature qw/say/;

my @mat = ([qw<7 8 9>], [qw<1 2 3>],  [qw<4 5 6>] );
my @best_path;
my $min = 0;
for my $row (@mat) {
    $min += $_ for @$row;
}
my @empty_path;

traverse_mat(0, 0, 0, ());

sub traverse_mat {
    my ($i, $j, $sum, @path) = @_;
    my $new_sum = $sum + $mat[$i][$j];
    return if $new_sum > $min;
    my @new_path = (@path, $mat[$i][$j]);
    if (defined $mat[$i][$j+1]) {
        traverse_mat($i, $j+1, $new_sum, @new_path);
    }
    if (defined $mat[$i+1][$j]) {
        traverse_mat($i+1, $j, $new_sum, @new_path);
    }
    unless (defined $mat[$i][$j+1] or defined $mat[$i+1][$j]) {
        @best_path = @new_path;
        $min = $new_sum;
    }
}
say $min, " (", join(' → ', @best_path), ")";
