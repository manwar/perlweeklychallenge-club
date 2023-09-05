unit module challenge-nr233::athanasius::raku::task-one:ver<0.0.1>:auth<athanasius@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/athanasius/raku/ test/challenge-nr233/raku/task-one.rakutest

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@words) is export {
	subset Alpha of Str  where m:i/ ^ <[ a..z ]>+ $ /;
	subset APair of List where (Alpha, Alpha);
	my Bool constant $VERBOSE = True;

    my Array[APair] $pairs = find-pairs( @words );
    my UInt         $count = $pairs.elems;
    return $count;

}

sub find-pairs( List:D[Alpha:D] $words --> List:D[APair:D] )
{
    my Set %dict{Str};

    for @$words -> Alpha $word
    {
        %dict{ $word } = set $word.lc.split: '', :skip-empty;
    }

    my APair @pairs;

    for 0 .. $words.end - 1 -> UInt $i
    {
        my Alpha $word1 = $words[ $i ];

        for $i + 1 .. $words.end -> UInt $j
        {
            my Alpha $word2 = $words[ $j ];

            # Note: ≡ is the identity operator, also written (==)

            @pairs.push: Array[Alpha].new( $word1, $word2 )
                if %dict{ $word1 } ≡ %dict{ $word2 };
        }
    }

    return @pairs;
}