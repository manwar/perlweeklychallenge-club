#! /opt/local/bin/perl
#
#       multiplication.pl
#
#       PWC 33 - Task #2
#       Formatted Multiplication Table
#           Write a script to print 11x11 multiplication table, only the top half triangle.
#
#            x|   1   2   3   4   5   6   7   8   9  10  11
#           ---+--------------------------------------------
#            1|   1   2   3   4   5   6   7   8   9  10  11
#            2|       4   6   8  10  12  14  16  18  20  22
#            3|           9  12  15  18  21  24  27  30  33
#            4|              16  20  24  28  32  36  40  44
#            5|                  25  30  35  40  45  50  55
#            6|                      36  42  48  54  60  66
#            7|                          49  56  63  70  77
#            8|                              64  72  80  88
#            9|                                  81  90  99
#           10|                                     100 110
#           11|                                         121
#
#       method: well, there is one quite straightforward way to output the table
#           above, and that is to simply output the table above. This satifies
#           the letter if perhaps not the spirt of the challenge. That
#           function can be examined in
#
#               sub cheap_and_dirty()
#
#           below.
#
#           With that out of the way, the table can be algorithmically produced
#           by an incrementing loop in turn iterating over all of the values
#           greater than the loop value, up to a given maximum, in this case 11.
#           Multipliying one value times the other will produce first all of the
#           1 x products starting with 1, then the 2 x products starting with
#           2, etc. A map function inside an anonymous list will produce the
#           required values.
#
#           In printing the table, to construct the triangle we can use a
#           printf function with a dynamic format string, with a builder within
#           each iteration using either numeric specifiers or blank spaces as
#           required; this in turn is fed by the mapped list of products
#           mentioned above. Easy peasy. The header row, the x-axis index, is
#           nearly identical to the 1 x product row, so it can be considered a
#           special case version of that, as is the dividing row, which can be
#           considered a special case using entirely dashes instead of spaces
#           or numbers. These are printed during the first iteration, before
#           the first 1 x product row.
#
#           But this is a general algorithm and can be applied to any upper
#           bound, so we can replace the fixed value 11 as a maximum and
#           in corelated calculated coefficiants with a variable, $range.
#           However if the spacing is fixed, say at the 4 characters used by
#           the sample 11x11 times table above, problems will arise in the
#           formatting, because large values will eventually exceed the space
#           provided and the table will no longer look pretty. This cannot
#           stand, as after all we have gone to great lengths to prettify the
#           output. We are saved from an ugly and miserable existance by
#           creating precalculated spacer variables specifiying the number of
#           characters required to fit the output products and factors
#           involved; we can substitute these values into our printf formats
#           and the table will automatically scale as required to fit the
#           output values.
#
#           The range of the table is set in the $range variable below. Try
#           setting other values. My machine begins to grind a bit in the mid
#           five figures somewhere.
#
#           YMMV.
#
#       2019 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## CONFIG

## this is specified by the challenge to 11, for an 11x11 times table, but can be set in this version to any positive integer
my $range = shift @ARGV // 11;         ## change the 11 here or use a command line argument

## ## ## ## ## MAIN

draw_times_table($range);

say "\n";

## or, alternately:
cheap_and_dirty();




## ## ## ## ## SUBS

sub draw_times_table {
    my $range = shift;

    ## autoscaling calculations:
    ##  we need to gather some basic spatial characteristics of the table we will draw
    my $space   = scalar( split //, ($range * $range) ) + 1;    ## count of chars required to fit largest number_format + 1 extra
    my $digits  = scalar( split //, ($range) ) + 1;             ## count of chars taken by the original specified range number + 1 extra
    my $product_format  = '%' . $space  . 'd';                  ## the format substring to print the largest product within the correct width
    my $number_format   = '%' . $digits . 'd';                  ## the format substring to print a factor within the correct width

    ## draw the table:
    for my $i (1..$range) {
        ## header index and dashed line
        if ( $i == 1) {
           my $format  =    (" " x ($digits-1)) . "x|" .   ((" " x $space) x ($i-1)) . ($product_format) x ($range - ($i-1)) . "\n";
           my $dash_format =  ("-" x ($digits)) .  "+" .   (("-" x $space) x $range)                                         . "\n";
           printf "$format", (map { $i * $_ } ($i..$range));
           printf "$dash_format";
        };
        ## table rows
        my $format     =          $number_format .  "|" .   ((" " x $space) x ($i-1)) . ($product_format) x ($range - ($i-1)) . "\n";
        printf "$format", $i, (map { $i * $_} ($i..$range));
    }
}

sub cheap_and_dirty {
say<<__END__
  x|   1   2   3   4   5   6   7   8   9  10  11
---+--------------------------------------------
  1|   1   2   3   4   5   6   7   8   9  10  11
  2|       4   6   8  10  12  14  16  18  20  22
  3|           9  12  15  18  21  24  27  30  33
  4|              16  20  24  28  32  36  40  44
  5|                  25  30  35  40  45  50  55
  6|                      36  42  48  54  60  66
  7|                          49  56  63  70  77
  8|                              64  72  80  88
  9|                                  81  90  99
 10|                                     100 110
 11|                                         121
__END__
}
