USING: kernel sequences prettyprint math.matrices arrays ranges math.statistics tools.test ;
IN: pwc-341
:: ch-1 ( seq m -- n )
  seq length <iota> dup dup cartesian-product concat cartesian-product concat
  [ first2 swap prefix ] map [
    [ first3 2dup < nip [ < ] dip and ]
    [ seq nths differences [ m = ] all? ] bi and
  ] filter length ;

{ 2 } [ { 0 1 4 6 7 10 } 3 ch-1 ] unit-test
{ 2 } [ { 4 5 6 7 8 9 } 2 ch-1 ] unit-test
