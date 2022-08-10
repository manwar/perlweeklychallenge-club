#!raku

# Perl Weekly Challenge 177

sub MAIN( Int $number-to-check, Bool :$verbose = True ) {

    my @check-table =
                     [ 0, 3, 1, 7, 5, 9, 8, 6, 4, 2 ],
                     [ 7, 0, 9, 2, 1, 5, 4, 8, 6, 3 ],
                     [ 4, 2, 0, 6, 8, 7, 1, 3, 5, 9 ],
                     [ 1, 7, 5, 0, 9, 8, 3, 4, 2, 6 ],
                     [ 6, 1, 2, 3, 0, 4, 5, 9, 7, 8 ],
                     [ 3, 6, 7, 4, 2, 0, 9, 5, 8, 1 ],
                     [ 5, 8, 6, 9, 7, 2, 0, 1, 3, 4 ],
                     [ 8, 9, 4, 5, 3, 6, 2, 0, 1, 7 ],
                     [ 9, 4, 3, 8, 6, 1, 7, 2, 0, 5 ],
                     [ 2, 5, 8, 1, 4, 3, 6, 7, 9, 0 ];

    my $interim = 0;

    my @digits = $number-to-check.comb;
    my $check-digit = @digits[ * - 1 ];

    "Number $number-to-check will be checked as { @digits.join } against check digit $check-digit".say if $verbose;

    for @digits -> $column {
        "Digit $column (column) with interim (row) $interim => { @check-table[ $interim ][$column]}".say if $verbose;
        $interim = @check-table[ $interim ][$column];
    }

    "Number $number-to-check with last interim is $interim".say if $verbose;
    '1'.say and exit if $interim == 0;
    '0'.say;

}
