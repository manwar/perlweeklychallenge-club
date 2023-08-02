"use strict";

/* Task 1: Unique Sum
You are given an array of integers.
Write a script to find out the sum of unique elements in the given array.*/

function sumUnique ( elements ) {
    let elementCount = new Map();
    let sum = 0;
    for (let elem of elements) {
        elementCount.set(elem, (elementCount.get(elem) ?? 0 ) + 1);
    }
    for (let elem of elementCount.keys()){
        if( elementCount.get(elem) == 1){
            sum += elem;
        }
    }
    return sum
}
