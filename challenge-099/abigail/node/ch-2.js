#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js < input-file
//

//
// Read input from standard input, assuming one exercise per line.
// Each line consists of a string $S, and a pattern $T, separated
// by whitespace.
//    
require ('readline')
. createInterface ({input: process . stdin})   
. on ('line', _ => console . log (matches (... _ . split (' '))))
;


// 
// Recursively count matches:
//   - If either the string or the pattern is empty, there are no matches.
//   - Else, + count the matches if we don't match at the first character
//             if the string.
//           + if the first character of the string equals the first
//             character of the pattern:
//             o  add 1 if the pattern is just one character long
//             o  else, add the number of matches starting from the
//                then next character in the string, and the next
//                character in the pattern.
//
function matches (string, pattern) {
    if (string . length == 0 || pattern . length == 0) {
        return 0
    }
    let count = matches (string . substring (1), pattern);
    if (string . substring (0, 1) == pattern . substring (0, 1)) {
        if (pattern . length == 1) {
            count ++
        }
        else {
            count += matches (string . substring (1), pattern . substring (1))
        }
    }
    return count
}
