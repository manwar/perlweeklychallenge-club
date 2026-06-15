#!/opt/homebrew/bin/node
 
  require ('readline')
. createInterface ({input: process . stdin})
. on              ('line', line => {
      console . log (line . match (/(.).?\1|(.)(.).*\3\2/) ? "true" : "false")
  })
