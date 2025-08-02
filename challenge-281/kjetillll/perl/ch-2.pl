use strict; use warnings; use Test::More;

sub knight_steps {
    #represent the input positions in @_ of the form a1, b2 and so on as
    #numeric positions instead where the letters a-h becomes 10 20 30 40 50 60 70 80
    #and concat that with the digit so for example a1 becomes 101, c7 -> 307, h8 -> 808

    my( $from, $to ) = map s/./ 10*ord($&)-960 /er, @_; #convert input as described
    my @check = ( [$from, 0] );
    while( my($pos, $steps) = @{ shift @check } ){
        return $steps if $pos eq $to;
        push @check,              #push into work list
            map [$_, $steps+1],   #register new posible jumps
            grep /[1-8]0[1-8]/,   #don't keep jumps outside board
            map $pos + $_,        #jump to
            201,  102,  199,  98, #valid jumps
           -201, -102, -199, -98;
    }
}

ok knight_steps('g2' => 'a8') == 4;
ok knight_steps('g2' => 'h2') == 3;
ok knight_steps('h1' => 'a8') == 6;
ok knight_steps('c3' => 'c4') == 3;
ok knight_steps('a1' => 'a1') == 0;
done_testing;
