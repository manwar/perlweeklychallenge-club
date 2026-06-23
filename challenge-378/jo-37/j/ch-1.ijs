#!/usr/local/bin/jconsole

NB. (conjunction) create a tacit verb that finds the index of the n-th largest
NB. valid character in y within the characters defined by m
nth_largest =: conjunction define
   NB. (monad) get indices of chars in y as found in m
   NB. provides "# m" for characters not in m
   char_indices =. m&i.

   NB. (noun) array of _1's, one item larger than m - leaving one bucket
   NB. for non-valid chars
   buckets =. _1 $~ >: # m

   NB. (dyad) set y at indices specified by x to x
   NB. This is comparable with Perl's
   NB. "do {my @tmp = @y; @tmp[@x] = @x; @tmp}"
   set_self =. [`[ }

   NB. (monad) drop the last item from y
   curtail =. }:

   NB. (monad) drop negative items from y
   non_neg =. #~ 0&<:

   NB. (monad) return the n-th last item from y or _1 if it doesn't exist
   nth_last =. (-@n { ])`_1:@.(n > #)

   NB. find indices of the chars in y within m, set these indices in the
   NB. bucket array, drop the non-valid bucket and all negative values
   NB. and finally return the n-th last element (which is an index into m)
   ([: nth_last [: non_neg [: curtail buckets set_self~ char_indices) f. : [:
)

Examples =: 'aaaaa77777';'abcde';'9zero8eight7seven9';'xyz9876543210';'4abc4def2ghi8jkl2'
Expected =: _1;_1;8;8;4

3 : 0 (2}. ARGV)
    second_largest_digit =. (a. {~ 48+i.10) nth_largest 2
if.
    1 = # y
do.
    echo second_largest_digit > {. y
elseif.
    3 = # y
do.
    echo  (1 {:: y) nth_largest (". 2 {:: y) 0 {:: y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: second_largest_digit&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs STR [SEQ N]" to process string [sequence and selection]'
    echo 'or   "./ch-1.ijs"             to run the examples'
end.
)

exit ''