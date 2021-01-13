use v6.d;

#
#       colorful.raku
#
#         TASK #2
#         Colourful Number
#             Write a script to display all Colorful Number with 3 digits.
#
#             A number can be declare Colorful Number where all the products of
#             consecutive subsets of digit are different.
#
#             For example, 263 is a Colorful Number since 2, 6, 3, 2x6, 6x3, 2x6x3
#             are unique.
#
#         method: for this challenge, we're structurally dealing with the values of
#            individual digits that make up a three digit number and recombining
#            them in different ways.
#
#            We can extract these digits mathematically, but in Raku we can treat the
#            candidate number as a string and use comb to extract the individual chars
#            into an array all at once. Once we have the digits, the particular
#            recombinations studied match a fixed set of arrays of indexes to this
#            comb array; these indexes can be written as a list. Applying the product
#            reduction metaoperator to the values pointed to by each set of indexes in
#            turn yields the products we are studying.
#
#            We can determine whether these values are unique by making them
#            hash keys and examining the resultant hash; duplicate values will
#            overwrite existing keys. When counting the keys of the hash, if we
#            have 6 keys then all are unique and the number is determined
#            sufficiently flashy to be declared colorful. At no point do we ever
#            care as to what the values actually are, we only want to know
#            whether they are unique.
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

sub MAIN () {

    for (100..999) -> $val {
        my @list = $val.comb;
        my %out = ([0],[1],[2],[0,1],[1,2],[0..2]).map( {([*] @list[$_.list]) => 1} );
        $val.say if %out.keys.elems == 6;
    }

}
