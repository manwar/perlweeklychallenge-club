#!raku

sub MAIN( Str $S where { $S.chars > 2 } ) {

    my $fnr = Nil;
    my @result;
    my %counting;
    my @chars = $S.comb( '', :skip-empty );
    for 0 ..^ @chars.elems {
        my $current-char = @chars[ $_ ];

        if ! $fnr {
            $fnr = $current-char;
        }
        elsif $current-char ~~ $fnr {
            my %counting;
            %counting{ $_ }++ for @chars[ 0 .. $_ ];
            $fnr = %counting.pairs.grep( { .value == 1 && .key !~~ $current-char } ).first.key // '#';
            "selezionato $fnr".say;
        }
        elsif $_ !~~ $fnr  {
            say "$fnr $current-char";
            $fnr = $current-char;
        }
        else {
            $fnr = '#';
        }


        @result.push: $fnr;

    }

    @result.join.say;
}
