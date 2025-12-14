! Copyright (C) 2025 Your name.
! See https://factorcode.org/license.txt for BSD license.
USING: grouping kernel math prettyprint sequences sets.extras ;
IN: 351part1

: filtermin ( a -- a ) dup minimum [ = not  ] curry filter ;
: filtermax ( a -- a ) dup dup length 0 > [ maximum [ = not  ] curry filter ] [ drop ] if   ;

: avglength ( a -- a ) dup length 0 > [ [ length ] keep sum swap / ] [ drop 0 ] if  ;

: specialavg ( a -- a ) filtermin filtermax avglength ;
