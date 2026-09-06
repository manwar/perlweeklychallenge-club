#!/opt/homebrew/bin/node
 
  require ('readline')
. createInterface ({input: process . stdin})
. on              ('line', line => {
    let parts = line . split (/\s+/)
    let notes = []
    let nr_of_notes = Math . floor (parts . length / 2)
    for (let i = 1; i <= nr_of_notes; i ++) {
        notes [+parts [i + nr_of_notes] - 1] = parts [i]
    }
    console . log (parts [0] . toUpperCase () + " => " + notes . join (" "))
})
