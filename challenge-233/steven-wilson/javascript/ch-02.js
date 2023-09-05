"use strict";


function frequencySort(elements) {
    let elemCount = new Map();
    for (let elem of elements){
        elemCount.set( elem, (elemCount.get(elem) ?? 0) + 1 );
    }
    elements.sort(function(a,b){
        return elemCount.get(a) - elemCount.get(b) || b - a;
    });
    return elements;
}
