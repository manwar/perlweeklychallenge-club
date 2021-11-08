#!raku

sub MAIN( Int $N where { $N >= 10 } ) {
    my @digits = $N.split( '', :skip-empty );
    my $min-length = 1;

    my @numbers;

    my $i = 0;
    my $done = True;
    while $done && $i < @digits.elems {

        

        # first number ever
        @numbers.push: @digits[ $i ] if ! @numbers;
        my $current-number = @numbers[ * - 1 ];

        # compute available next numbers
        my @next-number    = $current-number + 1, $current-number - 1;

        # see if there is room for any of the next
        # numbers in the remaining array of digits
        $done = False;
        for @next-number {
            my $length = $_.Str.chars;
            if $i + $length < @digits.elems {
                my $current = @digits[ $i + 1 .. $i  + $length ].join.Int;
                if $current == $_ {
                    @numbers.push: $current;
                    $i += $length;
                    $done = True;
                    last;
                }
            }
        }
    }

    # all done
    say @numbers if $done;
}
