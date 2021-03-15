use strict;
use warnings;
use feature "say";

my $triangle = [ [1], [2,4], [6,4,9], [5,1,7,2] ];
# $triangle = [ [1], [2,4], [6,30,9], [30,30,30,2] ];
my $min_path = [ map { $_->[0] } @$triangle];
my $min_path_val = sum($min_path);
my $index = 0;
find_min_path($triangle, [], $index);
say "@$min_path";

sub sum {
    my $aref = shift;
    my $sum = 0;
    $sum += $_ for @$aref;
    return $sum;
}

sub find_min_path {
    my ($tri_ref, $path, $index) = @_;
    my @triangle = @$tri_ref;
    my @first_row = @{$triangle[0]};
    my @new_triangle = @triangle[1 .. $#triangle];
    my $new_path = [ @$path, $first_row[$index] ];
    if (@new_triangle) {
        find_min_path([@new_triangle], $new_path , $index);
        find_min_path([@new_triangle], $new_path, $index + 1);
    } else {
        my $new_path_val = sum($new_path);
        if ($new_path_val < $min_path_val) {
            $min_path = $new_path;
            $min_path_val = $new_path_val;
        }
    }
}
