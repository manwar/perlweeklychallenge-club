#!raku

# You are given a matrix of size M x N having only 0s and 1s.
#
# Write a script to set the entire row and column to 0 if an element is 0.

sub print-matrix( @matrix, $m, $n ){
    say "----" ~  "--" x $m;
    for 0 ..^ $m -> $row {
        print "| ";
        for 0 ..^ $n -> $column {
            print "@matrix[ ( $row * $m ) + $column ] ";
        }
        say " |";
    }
    say "----" ~  "--" x $m;
}


sub MAIN( Int $m, Int $n, *@incoming-matrix  ) {
    my @matrix = @incoming-matrix;
    "Original matrix was ".say;
    print-matrix( @incoming-matrix, $m, $n );
    my @zeros = @matrix.grep( * == 0, :k );

    for @zeros -> $zero-at {
        my ( $row, $column ) = ( $zero-at - 1 / $m ).Int, ( $zero-at % $n ).Int;
        @matrix[ $_ + $row ] = 0  for 0 ..^ $m;  # zero the rows
        @matrix[ $column + ( $_ * $m ) ] = 0  for 0 ..^ $n; # zero the columns
    }

    "Transformed matrix is".say;
    print-matrix( @matrix, $m, $n );

}
