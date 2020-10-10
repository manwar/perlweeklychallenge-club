"use strict"

console.log( candy_count( [1, 2, 2] ) );
console.log( candy_count( [1, 4, 3, 2] ) );


function candy_count( candidates ) {
    let total = 0;
    console.log( candidates );
    for ( let i in candidates ) {
        i = parseInt(i); // string by default
        let v = candidates[i];
        let prev = candidates[i-1] || 0;
        let next = candidates[i+1] || 0;
        total ++;
        if ( v > prev && prev != 0 ) { total ++ }
        if ( v > next && next != 0 ) { total ++ }
    }
    return total;
}


