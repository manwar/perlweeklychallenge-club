#!/opt/homebrew/bin/node
 
  require ('readline')
. createInterface ({input: process . stdin})
. on              ('line', line => {
    let list = [... line . trim () . split (/\s+/)]
    let n    = parseInt (list . shift ())
    //
    // Special case if n exceeds the size of the list
    //
    if (n > list . length) {
        console . log ("-1;")
        return
    }

    //
    // Calculate the size of the sets, and now many sets
    // will have one more element
    //
    let per_set  = Math . floor (list . length / n)
    let overflow =               list . length - n * per_set

    //
    // Print the sets
    //
    let ptr = 0
    for (let i = 1; i <= n; i ++) {
        //
        // Calculate the size of the current set
        //
        let set_size = per_set
        if (i <= overflow) {
            set_size ++
        }
        //
        // Print current set
        //
        process . stdout . write (list . slice (ptr, ptr + set_size)
                                       . join (" ") + "; ")
        ptr += set_size
    }
    process . stdout . write ("\n")
})
