#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js < input-file
//

const fs       = require ('fs')
const readline = require ('readline')
const printf   = require ('printf')

readline . createInterface ({input: process . stdin})   
         . on ('line', _ => main (... _ . split (" ")))

function main (start_time, current_time, file_name) {
    let time_diff = (current_time - start_time) * 1000;

    //
    // Read in the media file, into an array tracks.
    // Calculate the total time of playing all the tracks.
    //
    let tracks = require ("fs") . readFileSync (file_name)
                                . toString ()
                                . split ("\n")
                                . filter (_ => _ . length)
                                . map (_ => _ . split (",", 2))
                                . map (_ => [+_ [0], _ [1]])
    let total_time = 0;
    tracks . forEach (_ => total_time += _ [0])

    //
    // Don't care about full loops
    //
    time_diff %= total_time

    //
    // Find the right track and print it.
    //
    done = 0
    tracks . forEach (track => {
        if (!done) {
            if (time_diff - track [0] < 0) {
                console . log (track [1])
                time_diff   = Math . floor  (time_diff / 1000)
                let hours   = Math . floor  (time_diff / 3600)
                let minutes = Math . floor ((time_diff % 3600) / 60)
                let seconds =                time_diff         % 60

                if (hours > 0) {
                    console . log (
                        printf ("%02d:%02d:%02d", hours, minutes, seconds)
                    )
                }
                else {
                    console . log (
                        printf (     "%02d:%02d",        minutes, seconds)
                    )
                }
                done = 1  // There's no 'break' when using forEach
            }
            else {
                time_diff -= track [0]
            }
        }
    })
}
