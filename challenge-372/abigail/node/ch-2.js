#!/opt/homebrew/bin/node
 
  require ('readline')
. createInterface ({input: process . stdin})
. on              ('line', line => {
      //
      // Turn the input into an array of characters, sans the newline
      //
      let chars = [... line . matchAll (/./g) . map (m => m [0])]

      let max   = -1  // Track maximum distance

      for (let f = 0; f < chars . length; f ++) {         // For each character,
          for (let l = chars . length - 1; l > f; l --) { // find matching char
              if (chars [f] == chars [l]) {               // from the end
                  if (l - f - 1 > max) {                  // If larger distance
                      max = l - f - 1                     // remember it
                  }
                  break
              }
          }
      }

      console . log (max)
  })
