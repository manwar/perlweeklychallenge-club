#!raku

# Perl Weekly Challenge 179

sub MAIN( Int $n where { 0 < $n < 1000 } ) {

    my @units = 'first',
                'second',
                'third',
                'foruth',
                'fifth',
                'sixth',
                'seventh',
                'eigth',
                'nineth',
                'tenth';

    my @teens = 'eleven', 'twelve', 'thriteen', 'fourteen', 'fifteen', 'sixteen', 'seventeen',
                'eigtheen', 'nineteen';
    my @non-teens = 'twenty', 'thirty', 'fourty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety';

    given ( $n ) {
        when $_ <= 10 { @units[ $n - 1 ].say; }
        when $_ < 20  { @teens[ ( $n - 1 ) % 10 ].say; }
        when $_ >= 20 {
            say @non-teens[ ( $n / 10 ).Int - 2 ]
                ~ ( $n %% 10 ?? '' !! @units[ ( $n % 10 ) - 1 ] );
        }

    }

}
