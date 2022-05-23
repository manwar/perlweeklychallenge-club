#!raku

# Perl Weekly Challenge 166

sub MAIN( Str $filename = '../../data/dictionary.txt', Int $limit = 100 ) {
    my %substitutions = 'o' => 0, 'l' => 1, 'i' => 1, 's' => 5, 't' => 7;

    my @results = lazy gather {
        for $filename.IO.lines -> $word is copy {
            next if $word.chars > 8 || $word.chars < 2;
            next if $word.lc !~~ / ^ <[a..folist]>+ $ /;

            $word .= lc;
            my $src-word = $word;

            #$word .= subst( $_, %substitutions{ $_ } ) for %substitutions.keys;
            for %substitutions.kv -> $k, $v {
                $word ~~ s:g/$k/$v/;
            }

            take [ $src-word.uc, $word.uc ];
        }
    };


    @results[0 .. $limit].map( { "The word $_[0] is translated to $_[1]" } ).join( "\n" ).say;
}
