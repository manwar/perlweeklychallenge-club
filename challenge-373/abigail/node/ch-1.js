#!/opt/homebrew/bin/node
 
  require ('readline')
. createInterface ({input: process . stdin})
. on              ('line', line => {
    let parts = [... line . trim       ()                     // Remove newline
                          . replaceAll (/\s+/g, "")           // Remove spaces
                          . replaceAll (/\./g,  "")           // Remove dots
                          . split      (/;/)]                 // Split on ;
    console . log (parts [0] == parts [1] ? "true" : "false") // Equal?
  })
