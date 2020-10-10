"use strict"

console.log( spnm( [5, 2, -2, 0 ] ));
console.log( spnm( [1, 8, -1 ] ));
console.log( spnm( [2, 0, -1 ] ));
console.log( spnm( Array(12).fill().map((n, i) => 1 + i) ));

function spnm ( array ) {
  let list = array.filter( i => i > 0 );
  let max = 1 + Math.max(...list);
  let range = Array(max).fill().map((n, i) => 1 + i) ;
  let hash = {};

  for ( let i in list ) {
    let n = list[i];
    hash[n]=1;
  }

  for ( let i in range ) {
    let n = range[i];
    if ( !hash[n] ) { return n }
  }
  return -1
}

