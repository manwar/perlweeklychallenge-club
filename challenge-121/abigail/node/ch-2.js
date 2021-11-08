#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js < input-file
//

let matrix =
  require ('fs')
. readFileSync (0)                       // Read all.
. toString     ()                        // Turn it into a string.
. split        ("\n")                    // Split on newlines.
. filter       (_ => _ . length)         // Filter out empty lines.
. map          (_ => _ . split (' ')     // Split each line on commas.
                       . map (_ => +_))  // Turn into numbers.

function shortest_path (matrix, from, to, exclude) {
    if (1 + Object . keys (exclude) . length == matrix . length) {
        return [matrix [from] [to], [to]]
    }
    let shortest = Number . MAX_SAFE_INTEGER
    let sh_path  = []
    let new_exclude = Object . assign ({}, exclude)
    new_exclude [from] = 1
    for (let next = 0; next < matrix . length; next ++) {
        if (next == from || next == to || exclude [next] == 1) {
            continue
        }
        let [l, path] = shortest_path (matrix, next, to, new_exclude)
        if (shortest > l + matrix [from] [next]) {
            shortest = l + matrix [from] [next]
            sh_path  = path . slice ()
            sh_path . unshift (next)
        }
    }
    return [shortest, sh_path]
}

let [length, path] = shortest_path (matrix, 0, 0, {})

process . stdout . write (length + "\n")
process . stdout . write ("0 " + path . join (" ") + "\n")
