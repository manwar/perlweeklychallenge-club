#!/opt/homebrew/bin/node
 
  require ('readline')
. createInterface ({input: process . stdin})
. on              ('line', line => {
    if (line . match (/^[a-h][1-8] [a-h][1-8]$/)) {
        p1 = (line . codePointAt (0) % 2) == (line . codePointAt (1) % 2)
        p2 = (line . codePointAt (3) % 2) == (line . codePointAt (4) % 2)

        console . log (p1 && p2 || !p1 && !p2 ? "true" : "false")
    }
  })
