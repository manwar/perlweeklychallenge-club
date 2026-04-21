#!/opt/homebrew/bin/node
 
  require ('readline')
. createInterface ({input: process . stdin})
. on              ('line', line => {
     //
     // Parse input
     //
     var [str, size, filler] = line . split (" ")
     size = +size

     //
     // Add 'size - 1' filler characters to the string
     //
     str = str + filler . repeat (size - 1)

     //
     // While the string has at least 'size' characters left,
     // move the first 'size' characters to the output array
     //
     var out = []
     while (str . length >= size) {
        out . push (str . substr (0, size))
        str = str . substr (size)
     }

     //
     // Print the resulting array
     //
     console . log (out . join (" "))
  })
