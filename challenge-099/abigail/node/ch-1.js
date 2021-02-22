#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js < input-file
//

require ('readline')
. createInterface ({input: process . stdin})   
. on ('line', _ => console . log (matches (... _ . split (/ +/))))
;


// 
// Use a recursive method to see whether a pattern matches a string:
// ("PPP" is any pattern, possible empty; the string is of the form
//  "sSSS" (if non-empty), where "s" is any single character, and "SSS"
//  a possible empty substring).
//
//    - If both the string and pattern are empty, the match succeeds.
//    - If the string is empty:
//         o If the pattern is of the form "*PPP", the result is the
//           match of the string against "PPP"
//         o Else, the match fails.
//    - If pattern is the form "*PPP":
//         o if the pattern is "*", the match succeeds.
//         o if the pattern is of the form "**PPP", the result is the match
//           of the  string against "*PPP".
//         o if "SSS" (that is, the string without its leading character)
//           is matches by the pattern, the match succeeds
//         o if the pattern is of the form "*sPPP", or "*?PPP" (that is,
//           the character after the leading * is a ? or the first character
//           of the string), the results of the match is the match of
//           "SSS" against "PPP".
//         o else, the match fails.
//    - If the string is of the form "sSSS", and the pattern is of the
//      form "sPPP" or "?PPP", the result of the match is the match of
//      "SSS" against "PPP".
//    - Else, the match fails.
//
function matches (string, pattern) {
    let first_string   = string  . length > 0 ? string  . substring (0, 1) : ""
    let first_pattern  = pattern . length > 0 ? pattern . substring (0, 1) : ""
    let second_pattern = pattern . length > 1 ? pattern . substring (1, 2) : ""

    if (pattern . length == 0) {
        //
        // If we have exhausted the pattern, we have a match
        // if, and only if, we have exhausted the string.
        //
        return string . length > 0 ? 0 : 1
    }
    if (string . length == 0) {
        //
        // If we have exhausted the string, then if the pattern
        // starts with '*', we consume the '*' and recurse.
        // Else, the match fails.
        //
        return first_pattern == "*" ? matches (string, pattern . substring (1))
                                    : 0
    }

    if (first_pattern == "*") {
        if (second_pattern == "") {
            //
            // If pattern is *, it's match, no matter what is in $string.
            //
            return 1
        }

        if (second_pattern == "*") {
            //
            // If pattern starts with '**', consume one '*' and recurse.
            //
            return matches (string, pattern . substring (1))
        }

        //
        // Try matching the first character of $string against '*',
        // and recurse -- if this is a match, return 1.
        //
        if (matches (string . substring (1), pattern)) {
            return 1
        }

        if (second_pattern == "?" ||
            second_pattern == first_string) {
            //
            // If the pattern starts with '*?', or '*X', where X is
            // the first character of $string, match the '*' with an
            // empty string, and the ? or X with the first character
            // of $string, and recurse.
            //
            return matches (string . substring (1), pattern . substring (2))
        }

        //
        // Else, it's a failure 
        //
        return 0
    }

    //
    // If the first character of $pattern matches the first character
    // of $string, or if the first character of $pattern equals '?',
    // match the first characters, and recurse with the rest.
    // Else, the match fails.
    //
    return first_pattern == first_string ||
           first_pattern == "?" ? matches (string  . substring (1), 
                                           pattern . substring (1))
                                : 0
}
