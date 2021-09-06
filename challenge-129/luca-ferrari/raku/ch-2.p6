#!raku

class LL {
    has Int $.value = -1;
    has Bool $.available is rw = True;
    has LL $.next is rw = LL;


    method length() {
        my $counter = 1;
        my $current = self;
        $counter++ && $current = $current.next while ( $current.next );
        return $counter;
    }


    method pop-last() {
        my $current  = self;
        return Nil if ! $current.available;

        while ( $current.available && $current.next && $current.next.available ) {
            $current  = $current.next;
        }

        $current.available = False;
        return $current;
    }

    method print() {
        print $!value;
        if ( $!next  ) {
            print " -> ";
            $!next.print;
        }
    }
}


sub MAIN() {
    my $L1 = LL.new( value => 1 );
    $L1.next = LL.new( value => 2 );
    $L1.next.next = LL.new( value => 3 );
    $L1.next.next.next = LL.new( value => 4 );
    $L1.next.next.next.next = LL.new( value => 5 );

    my $L2 = LL.new( value => 6 );
    $L2.next = LL.new( value => 5 );
    $L2.next.next = LL.new( value => 5 );

    say "L1 = " ~ $L1.length;
    say "L2 = " ~ $L2.length;

    my ( $sum, $carry ) = 0, 0;
    my @sums;
    for 0 ..^ max( $L1.length, $L2.length ) {
        my ( $a, $b ) = ( $L1.pop-last, $L2.pop-last );
        my $sum = $carry
                   + ( $a ?? $a.value !! 0 )
                   + ( $b ?? $b.value !! 0 );

        if ( $sum >= 10 ) {
            $carry = ( $sum / 10 ).Int;
            $sum %= 10;
        }
        else {
            $carry = 0;
        }

        @sums.push: $sum;
    }


    my $R;
    my $current;
    my $previous;
    for @sums {
        $current = LL.new( value => $_, next => ( $previous ?? $previous !! Nil ) );
        $previous = $current;
    }

    say $current.print;




}
