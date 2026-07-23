#!/opt/homebrew/bin/node
 
  require ('readline')
. createInterface ({input: process . stdin})
. on              ('line', line => {
    let todo = [line]
    while (todo . length > 0) {
        let word = todo . shift ()
        if (word . match (/\?/)) {
            todo . push (word . replace (/\?/, "0"),
                         word . replace (/\?/, "1"))
        }
        else {
            process . stdout . write (word + " ")
        }
    }
    process . stdout . write ("\n")
})
