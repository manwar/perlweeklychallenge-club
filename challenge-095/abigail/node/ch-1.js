//
// Make a pattern matching an unsigned decimal number.
//
var XRegExp = require ('xregexp');
var pattern = XRegExp ('^\\p{Nd}+(?:\\.\\p{Nd}+)?$', 'u');

  require      ("fs")
. readFileSync (0)               // Read all.
. toString     ()                // Turn it into a string.
. split        ("\n")            // Split on newlines.
                                 // Remove trailing empty line.
. filter       ((_, i, a) => i != a . length - 1)
                                 // Check wether the input is a) a palindrome,
                                 // and 2) a decimal number.
                                 //
. map          (_ => console . log (_ == _ . split   ("")
                                           . reverse ()
                                           . join    ("") &&
                                    XRegExp . match (_, pattern) ? 1 : 0))
;
