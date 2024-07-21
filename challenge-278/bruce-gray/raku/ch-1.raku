# Variations explored:
#   The whitespace is handled by:
#       `.words`
#       `% \s+` in a regex
#   Regex expressed as:
#       Inline `/regex/`
#       Extracted `my Regex...`
#       Grammar
#   Parsing done:
#       Once, then sorted in a DS for use later
#       Twice, first to get the sort key and again to remove the sort key.
#   Pieces after parsing represented as:
#       Positional: [ word, num ]
#       Positional: [ num, word ] to use default sorting
#       Named:      <LeadingWord><TrailingNumber> via Hash construction
#       Named:      <LeadingWord><TrailingNumber> via Grammar component names
#       Named:      <LeadingWord><TrailingNumber> via `$<foo>` assignment
#   Coercion into Str and Numeric is done:
#       Explicitly with `+` and `~`
#       Explicitly numified with `+` during `sort`, but implicitly stringified by call to `.join`.
#       Explicitly numified with `+` during `sort`, and no stringification needed.

# Variations deliberately not explored:
#   Using an Array (indexed by the trailing number) as a DS (which would be a very efficient Radix Sort)
#       Would not allow duplicated trailing numbers.
#           (which don't have to be a problem if it is OK to use original order as tie-breaker)
#       Would cause problems with large non-sequential trailing numbers.
#           (like 'foobar10000000000').
#   Using a Hash (indexed by the trailing number) as a DS
#       Would not allow duplicated trailing numbers. (as above)
#   Using a Hash (indexed by the leading word) as a DS
#       Would not allow duplicated words without losing the order of all but the last word.
#   Regex `\w+?` for leading word
#       Would not allow for multi-digit trailing ordering numbers.
#       Would not allow for embedded symbols in word.
#   Regex `\D+?` for leading word
#       Would not allow for embedded digits in word.
# Any of those unexplored variations are valid for the task (and examples) as given; I just targeted more varied use-cases.


sub task1a ( $words --> Str ) {
    $words ~~ / ^ ( (\S+?) (\d+) )+ % \s+ $ /
        orelse die;

    return $0.sort(+*.[1])».[0].join: ' ';
}

sub task1b ( Str $s --> Str ) {
    sub matchWN ( $s ) {
        $s ~~ / ^ (\S+?) (\d+) $ / orelse die;
        return (+$1, ~$0);
    }

    return $s.words.map(&matchWN).sort».[1].join: ' ';
}

sub task1c ( Str $s --> Str ) {
    grammar WordNums {
        rule  TOP            { ^ <WN>+ % \s+ $ }
        regex WN             { <LeadingWord><TrailingNumber> }
        regex LeadingWord    { \S+? }
        regex TrailingNumber { \d+ }
    }

    my $p = WordNums.parse($s)
        orelse die;

    # return $p.<WN>.sort( +*.<TrailingNumber> )».<LeadingWord>.join: ' ';

    my @wns = $p.<WN>;

    @wns .= sort: +*.<TrailingNumber>;

    return @wns».<LeadingWord>.join: ' ';
}

sub task1d ( $words --> Str ) {
    $words ~~ / ^ ( $<LeadingWord>=[\S+?] $<TrailingNumber>=[\d+] )+ % \s+ $ /
        orelse die;

    return $0.sort(+*.<TrailingNumber>)».<LeadingWord>.join: ' ';
}

sub task1e ( $words --> Str ) {
    sub parse_word_with_trailing_num ( $word ) {
        $word ~~ / ^ (\S+?) (\d+) $ /
            orelse die;

        return {
            LeadingWord    => ~$0,
            TrailingNumber => +$1,
        };
    }

    my @AoH = $words.words.map(&parse_word_with_trailing_num).sort(+*.<TrailingNumber>);

    return @AoH».<LeadingWord>.join: ' ';
}

sub task1f ( $words --> Str ) {
    my Regex $EndNum = / (\d+) $ /;

    return $words.words.sort({ $_ ~~ $EndNum ?? +$0 !! die })».subst($EndNum).join: ' ';
}


constant @tests =
    ( 'and2 Raku3 cousins5 Perl1 are4'                   , 'Perl and Raku are cousins' ),
    ( 'guest6 Python1 most4 the3 popular5 is2 language7' , 'Python is the most popular guest language' ),
    ( 'Challenge3 The1 Weekly2'                          , 'The Weekly Challenge' ),

    # Added tests for non-sequential numbering, multi-digit numbers,
    # embedded numbers, symbols, duplicated words, and duplicated order-numbers.
    #   https://shakespeare.mit.edu/hamlet/hamlet.2.2.html
    #   https://tvtropes.org/pmwiki/pmwiki.php/Recap/DragonBallZAbridgedE9

    ( 'Challenge11 The1 Weekly2'                         , 'The Weekly Challenge' ),

    ( 'Words14 What2 Words16 you6 lord?12 read,8 my10 Words18 do4', 'What do you read, my lord? Words Words Words' ),

    ( 'Happiest7 9minutes3 moment9 of11 my13 18seconds5 life15', '9minutes 18seconds Happiest moment of my life' ),
;
constant @subs =
    :&task1a,
    :&task1b,
    :&task1c,
    :&task1d,
    :&task1e,
    :&task1f,
;
use Test; plan +@subs * +@tests;
for @subs -> ( :key($sub_name), :value(&task1) ) {
    for @tests -> ( $in, $expected ) {
        is task1($in), $expected, "$sub_name : $in";
    }
}
