"use strict";

/* Task 2: Empty Array
You are given an array of integers in which all elements are unique.
Write a script to perform the following operations until the array is 
empty and return the total count of operations.
If the first element is the smallest then remove it otherwise move it to 
the end. */

function emptyArray ( elements ) {
    let operations = 0;
    while (elements.length > 0){
        let elemSorted = elements.toSorted();
        if(elemSorted[0] == elements[0]){
            elements.shift();
        }
        else {
            elements.push(elements.shift());
        }
        operations++;
    }
    return operations;
}
