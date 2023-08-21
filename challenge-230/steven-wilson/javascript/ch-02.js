"use strict";

function countWordsWithPrefix(prefix, ...words) {
    let count = 0;
    words.forEach(function(word) {
        if (word.indexOf(prefix) == 0) {
            count++;
        }
    });
    return count;
}
