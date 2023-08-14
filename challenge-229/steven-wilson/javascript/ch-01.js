"use strict";

function not_sorted ( elements ) {
    let not_sorted = [];
    for ( let elem of elements ) {
        let elem_sorted = elem.split("").sort().join("");
        let elem_sorted_reversed = elem_sorted.split("").reverse().join("");
        if ( !(  elem == elem_sorted || elem == elem_sorted_reversed ) ) {
            not_sorted.push( elem );
        }
    }
    return not_sorted.length;
}
