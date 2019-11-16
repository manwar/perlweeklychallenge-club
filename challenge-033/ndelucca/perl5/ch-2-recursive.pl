use strict;
use warnings;

die "Choose a matrix size" unless @ARGV;

my $size = shift @ARGV;

render_matrix($size);

sub render_matrix{

    my $max = $size;
    my $min = 1;
    my $w = 1 + length $max**2;

    my $matrix = [];
    matrix_generator($min,$max,$matrix);
    $matrix->[0]->[0] = "x";

    print row($w,$matrix->[0]->[0],"|", map { $matrix->[0]->[$_] } ($min..$max));
    print row($w,"-"x$w,"-"x($w-1)."+", map { "-"x$w } ($min..$max));

    for my $row ($min..$max){
        print row($w,$matrix->[$row]->[0],"|", map { $matrix->[$row]->[$_] || "" } ($min..$max));
    }
}

sub matrix_generator{

    my ($row_c,$max,$matrix) = @_;

    return if $row_c > $max;

    $matrix->[$row_c]->[0] = $row_c;

    row_generator($row_c,$row_c,$max,$matrix);

    $row_c++;

    matrix_generator($row_c,$max,$matrix);

}

sub row_generator{

    my ($row_c,$col_c,$max,$matrix) = @_;

    return if $col_c > $max;

    $matrix->[0]->[$col_c] = $col_c;

    $matrix->[$row_c]->[$col_c] = $col_c*$row_c;

    $col_c++;

    row_generator($row_c,$col_c,$max,$matrix);

}

sub cell{
    my $width = shift;
    return sprintf "%".$width."s",shift;
}

sub row{
    my $width = shift;
    my @row = ();
    push @row, cell($width,$_) foreach (@_);
    push @row, "\n";
    return @row;
}
