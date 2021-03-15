//
// Call as "node ch-1.js < ../t/input-1-X", for suitable X.
//
  require      ("fs")
. readFileSync (0)               // Read all.
. toString     ()                // Turn it into a string.
. split        ("\n")            // Split on newlines.
. filter       (_ => _ . length) // Filter out empty lines.
    //
    // Split each line on ', ', and remove the double quotes.
    // We now have a list of words.
    //
. map          (_ => _ . split (/,\s*/)
                       . map   (_ => _ . replace (/"/g, ''))
               )
    //
    // Iterate over the list of words, find the canonical representation
    // of each word (characters sorted), and store the words in a hash,
    // keyed by their canonical representation. 
    //
. map          (_ => _ . reduce ((hash, word) => {
                               let key = word . split ("")
                                              . sort  ()
                                              . join  ("");
                               hash [key] = hash [key] || [];
                               hash [key] . push (word);
                               return (hash);
                         }, {})
               )
    //
    // Print the results: sorted by key, the words in the order
    // of the input. Each word will be surrounded by double quotes
    // and separated by commas.
    //
. map          (hash => Object . keys (hash)
                               . sort ()
                               . forEach (_ => {
                                     console . log (
                                         hash [_] . map (_ => '"' + _ + '"')
                                                  . join (", ")
                                         )
                                 })
               )
;
