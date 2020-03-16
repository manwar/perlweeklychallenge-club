#!env raku
#
#
# Task 1
# <https://perlweeklychallenge.org/blog/perl-weekly-challenge-052/>
#
# Write a script to accept two numbers between 100 and 999.
# It should then print all Stepping Numbers between them.
#
# A number is called a stepping number if the adjacent digits
# have a difference of 1.
# For example, 456 is a stepping number but 129 is not.





sub MAIN( Int:D :$from where {  100 <= $from <= 999 },
          Int:D :$to where   { 100 <= $to <= 999 && $to > $from } ) {

    say "Searching STEPPING NUMBERs between $from and $to";


    # compose manually all possible stepping numbers
    # starting from the hundred value of the from number
    my ( $h, $d, $u ) = $from.comb;
    my ( $H, $D, $U ) = $to.comb;
    my @stepping = ();
    while ( $h <= $H ) {

        for 1, -1 {
            my $dd = ( 0 <= $h + $_ <= 9 ) ?? $h + $_ !! Nil;
            for 1, -1  {
                my $uu = ( 0 <= $dd + $_ <= 9 ) ?? $dd + $_ !! Nil;

                @stepping.push( $h * 100 + $dd * 10 + $uu ) if ( $uu && $dd );
            }
        }

        $h++;
    }

    say @stepping.grep( $from <= * <= $to ).join( "\n" );
    say "-----------------------";
}
