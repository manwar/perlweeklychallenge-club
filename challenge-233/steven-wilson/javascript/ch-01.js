"use strict";


function similarWords(elements) {
    let similar = 0;
    for (let i = 0; i < elements.length - 1; i++) {
        let elem = elements[i];
        for (let j = i + 1; j < elements.length; j++) {
            let elemNext = elements[j];
            if (compWords(elem, elemNext)) {
                similar++;
            }
        }
    }
    return similar;
}

function compWords(word1, word2) {
    let word1s = new Set(word1);
    let word2s = new Set(word2);
    return word1s.size === word2s.size && [...word1s].every((char) => word2s.has(char));
}
