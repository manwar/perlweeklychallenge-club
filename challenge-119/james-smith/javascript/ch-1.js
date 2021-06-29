TESTS = [ [101,86],[18,33] ];

TESTS.forEach(_ => console.log( swap_nibble( _[0] ) == _[1] ? 'OK' : '--' ) );
TESTS.forEach(_ => console.log( swap_nibble( _[1] ) == _[0] ? 'OK' : '--' ) );

function swap_nibble(_) {
  return (_>>4) | ((_&15)<<4);
}

