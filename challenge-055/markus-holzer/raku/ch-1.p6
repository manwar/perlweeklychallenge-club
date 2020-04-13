subset BinaryStr of Str where * ~~ /^ <[01]>+ $/;

sub USAGE() {
    print Q:c:to/EOH/;
    ch-1.p6 <binary-str>

        Example:
            ch-1.p6 010
    EOH
}

sub MAIN( BinaryStr $input )
{
    my $pad    = '%0' ~ $input.chars ~ 's';

    say "L: { .<l> } R: { .<r> } -> { sprintf $pad, .<flipped> }"
        for top-flips-of( $input );
}

sub top-flips-of( BinaryStr $input )
{
    my %result = flips-of( $input );
    |%result{ %result.keys.max };
}

sub flips-of( BinaryStr $input )
{
    my %result;

    for flips( $input.chars ) -> ( $l, $r )
    {
        my $flipped = do-flip( $input, $l, $r );
        my $ones    = $flipped.indices( '1' ).elems;

        %result{ $ones }.push({ :$l, :$r, :$flipped });
    }

    %result;
}

sub flips( Int $length )
{
    (^$length X ^$length).grep( -> ( $l, $r ) { $l <= $r })
}

sub do-flip( BinaryStr $input, Int $l, Int $r ) returns BinaryStr
{
    my @flips   = ( ^$input.chars ).map({ $l <= $_ <= $r ?? 1 !! 0 });
    my $flipped = :2( $input ) +^ :2( @flips.join );

    $flipped.base(2);
}