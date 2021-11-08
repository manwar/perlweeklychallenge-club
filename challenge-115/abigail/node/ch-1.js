#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js < input-file
//

  require ('readline')
. createInterface ({input: process . stdin})   
. on ('line', _ => check_for_cycl (_))
;


function check_for_cycl (line) {
    //
    // Read in the data, build a graph where the first and last
    // characters of the strings form the nodes, and we have a
    // directed edge from the beginning to the end of a string.
    //
    let strings = line . split (/\s+/)
    let nodes = {}   // Keep track of all the nodes
    let graph = {}
    strings . forEach (_ => {
        let first = _ . substr ( 0, 1)
        let last  = _ . substr (-1, 1)
        nodes [first] = 1
        nodes [last]  = 1
        if (!graph [first]) {
            graph [first] = {}    // No autovivification in Node.js
        }
        if (!graph [last]) {
            graph [last] = {}     // No autovivification in Node.js
        }
        graph [first] [last] = 1  // Add a node
    })


    //
    // Calculate the transitive closure of the graph using
    // the Floyd-Warshall algorithm
    //
    nodes = Object . keys (nodes)
    nodes . forEach (k => {
        nodes . forEach (i => {
            nodes . forEach (j => {
                if (!graph [i] [j] && graph [k] [j] && graph [i] [k]) {
                    graph [i] [j] = 1
                }
            })
        })
    })

    //
    // We have a loop iff there is at least one node which is
    // reachable from itself.
    //
    let out = 0
    nodes . forEach (i => {
        if (graph [i] [i]) {
            out = 1
        }
    })

    console . log (out)
}
