#!/opt/homebrew/bin/node
 
  require ('readline')
. createInterface ({input: process . stdin})
. on              ('line', input => {
      console . log (
        input . replaceAll  (/[^\sa-zA-Z]+/g, "")      // Remove non-letters,
                                                       // but keep spaces
              . replace     (/^\s+/, "")               // Remove leading space
              . replace     (/\s+$/, "")               // Remove trailing space
              . toLowerCase ()                         // Lower case all`
              . replaceAll  (/\s+([a-z])/g, ((_, x) => // Upper case letters
                               x . toUpperCase ()))    // following space;
                                                       // drop the space
              . replace     (/^/, "#")                 // Add leading '#'
              . substring   (0, 100)                   // Trim to 100 chars max
  )})
