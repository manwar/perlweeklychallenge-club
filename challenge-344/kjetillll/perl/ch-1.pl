sub f { split //, pop() + join('',@_) }

use Test::More tests => 5;
is_deeply [ 1, 2, 4, 6    ],  [ f( 1, 2, 3, 4    => 12   )], 'Example 1';
is_deeply [ 4, 5, 5       ],  [ f( 2, 7, 4       => 181  )], 'Example 2';
is_deeply [ 1, 0, 0, 0    ],  [ f( 9, 9, 9       => 1    )], 'Example 3';
is_deeply [ 1, 9, 9, 9, 9 ],  [ f( 1, 0, 0, 0, 0 => 9999 )], 'Example 4';
is_deeply [ 1, 0, 0, 0    ],  [ f( 0             => 1000 )], 'Example 5';
