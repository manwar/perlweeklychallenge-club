#!/opt/homebrew/bin/node
 
  require ('readline')
. createInterface ({input: process . stdin})
. on              ('line', line => {
    let chars = {}
    line . split ("") . forEach ((ch) => {
        if ("a" <= ch && ch <= "z") {
            chars [ch] ||= 0
            chars [ch] ++
        }
    })
    let max = {c: 0, v: 0}

    for (const [ch, count] of Object . entries (chars)) {
        index = "c"
        if (ch . match (/[aeiou]/)) {
            index = "v"
        }
        if (max [index] < count) {
            max [index] = count
        }
    }

    console . log (max ["c"] + max ["v"])
})
