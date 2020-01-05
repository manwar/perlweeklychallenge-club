use v6;

#
#       leonardo_numbers.p6
#
#       PWC41
#       TASK #2
#           Write a script to display first 20 Leonardo Numbers. Please checkout wiki page for more information.
#           For example:
#
#           L(0) = 1
#           L(1) = 1
#           L(2) = L(0) + L(1) + 1 = 3
#           L(3) = L(1) + L(2) + 1 = 5
#           and so on.
#
#       method: because we have the growing series directly available to refer
#           to no recursion is required. I have made the function return a list
#           for any quanity > 0, displayed with a nice little header.

#           In the list-generating function, the definition of the sequence
#           lends itself well to a given/when construction, but after making it
#           I realized the fall-through logic was so straightforward the outer
#           construct could be done away with completely. All cases just fall
#           through to the return at the end.

#           The heavy lifting on the Leonardo list is done in one line by adding
#           elements made by the reduce sum of the flattened two element tail
#           and 1. Nice.
#
#           The function doesn't have meaning for quantity values < 1, so a constraint is
#           added that the parameter given must be an Int greater than 0.
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##


sub MAIN ( Int:D $quan where {$quan > 0} = 20) {

    ## header
    say "the first $quan Leonardo numbers:";
    say "";
    say "index  |  number";
    say "-------+--------";

    ## data
    my $i;
    printf "%-2d        %d\n", ++$i, $_ for make_leonardo($quan);
}



## ## ## ## ## SUBS

sub make_leonardo ( Int:D $quan where {$quan > 0} ){
##  construct a list of the first n Leonardo numbers
##  requires no recursion if we have the growing list to refer to
    my @list = [1];                             ## L1 = 1
    @list.push: 1 if $quan > 1 ;                ## L2 = 1
    while ( @list.elems <= $quan-1 ) {
        @list.push: [+] flat @list.tail(2), 1;  ## reduce sum flattened list of last two elems and 1
    }
    return @list;
}
