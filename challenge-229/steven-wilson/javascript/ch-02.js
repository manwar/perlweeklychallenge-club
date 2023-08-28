"use strict";

function two_out_of_three ( ...elements ) {
    let elemCount = new Map();
    for ( let elem of elements ){
        let uniq_numbers = new Set(elem);
        for ( let num of uniq_numbers ){
            elemCount.set( num, (elemCount.get(num) ?? 0) + 1 );
        }
    }
    let two_out_of_three = [];
    elemCount.forEach((value, key) => {
        if ( value > 1 ){
            two_out_of_three.push(key);
        }
    });
    return two_out_of_three.sort();
}