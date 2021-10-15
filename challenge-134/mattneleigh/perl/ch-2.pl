#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @dimensions = (
    # Given cases
    [3, 3],
    [3, 5],

    # Additional test cases
    [10, 10]
);

foreach(@dimensions){
    my $table = generate_multiplication_table(@{$_});

    printf("Input: \$m = %d, \$n = %d\n", $_->[0], $_->[1]);
    printf("Output:\n\n");

    foreach(@{$table->{table}}){
        print("      $_\n");
    }
    print("\n");

    print("Distinct Terms: ", join(", ", @{$table->{distinct_terms}}) ,"\n");
    print("Count: ", scalar(@{$table->{distinct_terms}}), "\n");
    print("\n\n");
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Create a multiplication table containing a specified number of columns and
# rows
# Takes two arguments:
# * An integer M that defines how many rows will be in the table; this must be
#   at least two (2)
# * An integer N that defines how many columns will be in the table; this must
#   be at least two (2)
# Returns on success:
# * A ref to a hash containing the following fields:
#   {
#       table => [],             # A list of formatted strings comprising the
#                                # multiplication table with M * N products,
#                                # ready for output
#       distinct_terms => [],    # A list of distinct products contained within
#                                # the table
#   }
# Returns on error:
# * undef if either M or N is smaller than two (2)
################################################################################
sub generate_multiplication_table{
    my $m = int(shift());
    my $n = int(shift());

    my $N;
    my $max_factor_width;
    my $max_product_width;
    my %output = ();

    # Impose some notion of sanity on our
    # input values
    return(undef) if(($m < 2) || ($n < 2));

    $output{table} = [];
    $output{distinct_terms} = ();

    # The maximum factor width will be
    # determined by the initial value of $m;
    # the width required for factors from $n
    # is determined by the maximum product
    # width, which is $m * $n
    $max_factor_width = count_integer_characters($m);
    $max_product_width = count_integer_characters($m * $n);

    $N = $n;
    while($m--){
        my @row = ( );

        $n = $N;
        while($n--){
            my $term = ($m + 1) * ($n + 1);

            # Store the calculated product in this
            # row, and make a note of it in the
            # distinct terms table
            unshift(@row, $term);
            $output{distinct_terms}{$term} = 1;
        }

        # Include the $m factor for the vertical
        # axis that will appear in the table
        unshift(@row, $m + 1);

        # Make a nicely formatted row for output
        # and store it
        unshift(
            @{$output{table}},
            format_table_row(\@row, $max_factor_width, $max_product_width)
        );

        unless($m){
            # The last (top) row of products has
            # been calculated; add a couple more
            # things to the top of the table:
            unshift(
                @{$output{table}},

                # A row of $N factors for the horizontal
                # axis...
                format_table_row(
                    [ "x", (1 .. $N) ],
                    $max_factor_width,
                    $max_product_width
                ),

                # And a horizontal rule
                "-" x ($max_factor_width + 1)
                .
                "+"
                .
                "-" x (($max_product_width + 1) * $N)
            );
        }

    } # end while($m--)

    # Store the distinct terms for output-
    # convert the distinct terms table into
    # a list of its former keys
    $output{distinct_terms} = [
        sort({ $a <=> $b } keys(%{$output{distinct_terms}}))
    ];

    return(\%output);

}



################################################################################
# Format a multiplication table row for output
# Takes three arguments:
# * A ref to an array that must contain the M factor for that row and its
#   products with all values of N (e.g [ 4, 4, 8, 12, 16 ] )
# * The calculated width of the maximum value of M (e.g. 1)
# * The calculated width of the maximum of all the products of M and N (e.g. 2)
# Returns:
# * A formatted string suitable for the body of a multiplicatino table, with a
#   vertical bar between the factor and its appropriately-spaced products
#   (e.g. "4 |  4  8 12 16")
################################################################################
sub format_table_row{
    my $row = shift();
    my $max_factor_width = shift();
    my $max_term_width = shift();

    return(
        sprintf("%".$max_factor_width."s ", $row->[0])
        .
        "|"
        .
        join(
            "",
            map(
                { sprintf(" %".$max_term_width."s", $_) }
                @{$row}[1 .. $#$row]
            )
        )
    );

}



################################################################################
# Calculate the number of characters required to display an integer
# Takes one argument:
# * The number to examine
# Returns:
# * The number of characters required to display the provided number
# NOTE: If a non-integer number is provided, the number of characters required
# to display just the integer portion of the number will be calculated; if a
# negative number is provided, the character required to display the sign will
# be accounted for in the value returned
################################################################################
sub count_integer_characters{

    return(
        int(
            log(abs($ARG[0])) / log(10)
            +
            ($ARG[0] < 0 ? 2 : 1)
            +
            # Fudge because of round-off error...
            0.000000000000001
        )
    );

}



