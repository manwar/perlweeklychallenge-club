unit module challenge-nr233::athanasius::raku::task-one:ver<0.0.1>:auth<athanasius@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/athanasius/raku/ test/challenge-nr233/raku/task-one.rakutest

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@words) is export {
	
    my $pairs = find-pairs( @words );
    my UInt $count = $pairs.elems;
    return $count;

}

sub find-pairs( $words )
{
    my Set %dict{Str};

    for @$words -> $word
    {
        %dict{ $word } = set $word.lc.split: '', :skip-empty;
    }

    my @pairs;

    for 0 .. $words.end - 1 -> UInt $i
    {
        my $word1 = $words[ $i ];

        for $i + 1 .. $words.end -> UInt $j
        {
            my $word2 = $words[ $j ];

            # Note: ≡ is the identity operator, also written (==)

            @pairs.push: ($word1, $word2 )
                if %dict{ $word1 } ≡ %dict{ $word2 };
        }
    }

    return @pairs;
}