#!/usr/bin/env raku

subset Pos of Int where * > 0;
subset Neg of Int where * < 0;

multi number-colision-iter (  [Pos $t,*@ll], [Neg $h,*@rl] )  {
    with $t <=> -$h {
        when More { ($t,|@ll),     @rl  }
        when Less {      @ll, ($h,|@rl) }
        when Same {      @ll,      @rl  }
    }
}

multi number-colision-iter (  @tll, [$h,*@rl] )  {($h,|@tll),        @rl}

sub number-colision (+@list) {
    ((),@list), {number-colision-iter |$_ } ... *[1] eq Empty
    andthen .tail
    andthen .[0]
    andthen .reverse
}

multi MAIN (Bool :test($)!) {
    use Test;
    is number-colision-iter((2,), (3,-1)),((3,2),(-1,));
    is number-colision-iter((3, 2), (-1,)),((3,2),());
    is number-colision-iter((3, 2), (-4,)),((2,),(-4));
    is number-colision-iter((2,), (-4,)),((),(-4));
    is number-colision-iter((), (-4,)),((-4),());
    is number-colision(2,3,-1),(2,3);
    is number-colision(2,3,-4),(-4);
    is number-colision(1,-1),();
    is number-colision(3,2,-1,2,-1,-2,5,-4),(3,2,5);
    done-testing;
}

multi MAIN (*@list) {
    put number-colision @list
}
