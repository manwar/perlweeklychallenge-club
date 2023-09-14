"use strict";


function commonCharacters(...words) {
    let common = words.shift();
    let countCommon = new Map();
    for (let character of common) {
        countCommon.set( character, (countCommon.get(character) ?? 0) + 1 );
    }
    for (let word of words) {
        let countCharacters = new Map();
        for (let character of word) {
            countCharacters.set( character, (countCharacters.get(character) ?? 0) + 1);
        }
        for (let character of common) {
            if( word.indexOf(character) == -1 ) {
                let last = common.indexOf(character);
                common = common.slice(0, last) + common.slice(last+1);
            }
            else if (countCommon.get(character) > countCharacters.get(character)){
                countCommon.set( character, (countCommon.get(character) - 1));
                let last = common.lastIndexOf(character);
                common = common.slice(0, last) + common.slice(last+1);
            }
        }
    }
    return common.split("");
}
