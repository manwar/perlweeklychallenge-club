# Just as easy to solve this task for any number of lines, instead of just two.

# Common code for "list elements occuring only once".
constant &non-dups = *.Bag.grep( *.value == 1 )».key;

# Solves the problem along the lines of the actual description of the task.
sub task1_reduce ( @lines ) {
    return @lines.map( *.words.&non-dups ).reduce(&[⊎]).&non-dups || '';
}

# Re-thinking the task,
# it becomes clear that the distinction between lines in irrelevant;
# what is wanted are the words that only occur once in any line.
# Restated:
#       A word is uncommon
#       if it appears exactly once in one of the sentences
#       and doesn’t appear in other sentence.
# is logically mappable to:
#       A word is uncommon
#       if it appears exactly once
#       across all of the sentences.
sub task1_rethought ( @lines ) {
    return @lines».words.flat.&non-dups || '';
}

sub task1_set_subtraction ( @lines ) {
    # return keys( .list ∖ .repeated ) || '' given @lines».words.flat.cache; # One-liner; needlessly obtuse.

    my @w = @lines».words.flat;

    return ( @w (-) @w.repeated ).keys || '';
}


constant @tests =
    ( 'Mango is sweet' , 'Mango is sour'    , ( 'sweet', 'sour' ) ),
    ( 'Mango Mango'    , 'Orange'           , ( 'Orange',       ) ),
    ( 'Mango is Mango' , 'Orange is Orange' , ( '',             ) ),
;
constant @subs =
    :&task1_reduce,
    :&task1_rethought,
    :&task1_set_subtraction,
;
use Test; plan +@tests * +@subs;
for @subs -> ( :key($sub_name), :value(&task1) ) {
    for @tests -> ( $line1, $line2, @expected ) {
        is-deeply task1(($line1, $line2)).sort, @expected.sort, "$sub_name : $line1";
    }
}
