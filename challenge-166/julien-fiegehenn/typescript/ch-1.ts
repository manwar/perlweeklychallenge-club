// As an old systems programmer, whenever I needed to come up with a 32-bit number, I would reach for the tired old examples like 0xDeadBeef and 0xC0dedBad. I want more!

// Write a program that will read from a dictionary and find 2- to 8-letter words that can be “spelled” in hexadecimal, with the addition of the following letter substitutions:

// o ⟶ 0 (e.g., 0xf00d = “food”)
// l ⟶ 1
// i ⟶ 1
// s ⟶ 5
// t ⟶ 7
// You can use your own dictionary or you can simply open ../../../data/dictionary.txt (relative to your script’s location in our GitHub repository) to access the dictionary of common words from Week #161.

// Optional Extras (for an 0xAddedFee, of course!)
// Limit the number of “special” letter substitutions in any one result to keep that result at least somewhat comprehensible. (0x51105010 is an actual example from my sample solution you may wish to avoid!)
// Find phrases of words that total 8 characters in length (e.g., 0xFee1Face), rather than just individual words.

// read the dictionary and return an array of words
function readDictionary(fileName: string): string[] {
  const fs = require("fs");
  const dictionary = fs.readFileSync(fileName, "utf8").split("\n");
  return dictionary;
}

// Write a program that will read from a dictionary and find 2- to 8-letter words that can be “spelled” in hexadecimal, with the addition of the following letter substitutions:
function findWords(dictionary: string[], wordLength: number): string[] {
  const hexWords = [];
  const hexLetters = {
    o: "0",
    l: "1",
    i: "1",
    s: "5",
    t: "7",
  };
  const hexLettersRegex = new RegExp(Object.keys(hexLetters).join("|"), "g");
  for (let i = 0; i < dictionary.length; i++) {
    if (dictionary[i].length === wordLength) {
      let hexWord = dictionary[i].toLowerCase();
      hexWord = hexWord.replace(
        hexLettersRegex,
        (letter) => hexLetters[letter]
      );
      hexWord = hexWord.replace(/[^0-9a-f]/g, "");
      if (hexWord.length === wordLength) {
        // I changed this line, it wanted to compare to wordLength * 2
        hexWords.push(hexWord);
      }
    }
  }
  return hexWords;
}

// use readDictionary, iterate 2 to 8 and findWords
function findWordsInHex(dictionary: string[], wordLength: number): string[] {
  const hexWords = [];
  for (let i = 2; i <= wordLength; i++) {
    hexWords.push(...findWords(dictionary, i));
  }
  return hexWords;
}

console.log(findWordsInHex(readDictionary("../../../data/dictionary.txt"), 8));

const allHexWords: string[] = findWordsInHex(
  readDictionary("../../../data/dictionary.txt"),
  8
);
// output the last 10 hex words
console.log(allHexWords.slice(-10));

// find combinations of words from allHexWords that do not exceed 8 characters and combine them in camelCase
function findCamelCaseWords(allHexWords: string[]): string[] {
  const camelCaseWords = [];
  for (let i = 0; i < allHexWords.length; i++) {
    for (let j = 0; j < allHexWords.length; j++) {
      if (allHexWords[i].length + allHexWords[j].length <= 8) {
        camelCaseWords.push(
          allHexWords[i] +
            allHexWords[j].charAt(0).toUpperCase() +
            allHexWords[j].slice(1)
        );
      }
    }
  }
  return camelCaseWords;
}

// print 5 random camelcase words
console.log(
  findCamelCaseWords(allHexWords)
    .sort(() => 0.5 - Math.random())
    .slice(0, 5)
);

// ignore words from allHexWords that have consecutive 1s
function ignoreConsecutiveOnes(allHexWords: string[]): string[] {
  const camelCaseWords = [];
  for (let i = 0; i < allHexWords.length; i++) {
    if (!/1{2,}/.test(allHexWords[i])) {
      camelCaseWords.push(allHexWords[i]);
    }
  }
  return camelCaseWords;
}

// print 5 random strings from allhexwords that ignore consecutive 1s
console.log(
    ignoreConsecutiveOnes(allHexWords)
        .sort(() => 0.5 - Math.random())
        .slice(0, 5)
);

