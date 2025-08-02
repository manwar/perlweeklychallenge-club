#!/usr/bin/env raku

proto distributive-reducer ((@arr1,@arr2),  $int) {*}
multi distributive-reducer ((@arr1, @arr2), $int where @arr1 ~~ Empty)             { ($int,),       @arr2          }
multi distributive-reducer ((@arr1, @arr2), $int where @arr2 ~~ Empty )            { @arr1,         ($int,)        }
multi distributive-reducer ((@arr1, @arr2), $int where {@arr1.tail > @arr2.tail} ) { (|@arr1,$int), @arr2          }
multi distributive-reducer ((@arr1, @arr2), $int  )                                { @arr1,         (|@arr2, $int) }

sub distributive-elements (+ints) {
  ints
  andthen ((),()), |ints
  andthen .reduce: &distributive-reducer
  andthen |.head,|.skip.head
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply distributive-reducer(((),()),1), ((1,),());
    is-deeply distributive-reducer(((1,),()),2), ((1,),(2,));
    is-deeply distributive-reducer(((1,3),(2,)),4), ((1,3,4),(2,));
    is-deeply distributive-reducer(((1,),(2,)),3), ((1,),(2,3));
    is distributive-elements(2,1,3,4,5), (2,3,4,5,1);
    is distributive-elements(3, 2, 4), (3, 4, 2);
    is distributive-elements(5, 4, 3, 8), (5, 3, 4, 8);
    done-testing;
}

multi MAIN (+ints) {
    put distributive-elements ints
}
