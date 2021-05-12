#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js < input-file
//

  require ('readline')
. createInterface ({input: process . stdin})   
. on ('line', _ => {
    let parts = _ . split (/\/+/)              // Split on slash.
    let parts2 = []
    parts . every (_ => {
        if (_ == "." || _ == "") {             // Skip current directory,
            return true                        // and empty parts.
        }
        if (_ == "..") {                       // Pop parent directory.
            parts2 . pop ()
            return true
        }
        parts2 . push (_)                      // Copy part.
        return true
    })
    console . log ("/" + parts2 . join ("/"))  // Print result.
})
