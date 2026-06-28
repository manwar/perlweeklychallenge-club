#!/opt/homebrew/bin/node
 
  require ('readline')
. createInterface ({input: process . stdin})
. on              ('line', line => {
    let rev = ""
    if (line . length) {
        line . match (/./g) . forEach ((ch) => {
            rev = ch + rev
        })
    }
    console . log (rev)
})
