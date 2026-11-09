#!/opt/homebrew/bin/node

function next (i, max) {return i >= max - 1 ?       0 : i + 1}
function prev (i, max) {return i <=       0 ? max - 1 : i - 1}
 
  require ('readline')
. createInterface ({input: process . stdin})
. on              ('line', line => {
    let words = line . split (/\s+/)
    let diffs = words . map (word => {
        let offset = word . codePointAt (0) - "a" . codePointAt (0)
        return word . split ("")
                    . map   ((ch) => String . fromCodePoint (
                              ch . codePointAt (0) - offset))
                    . join ("")
    })

    diffs . some ((diff, index) => {
        if (diff != diffs [next (index, diffs . length)] &&
            diff != diffs [prev (index, diffs . length)]) {
            console . log (words [index])
            return 1
        }
    })
})
