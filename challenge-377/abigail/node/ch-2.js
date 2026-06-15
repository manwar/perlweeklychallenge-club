#!/opt/homebrew/bin/node
 
  require ('readline')
. createInterface ({input: process . stdin})
. on              ('line', line => {
    let words = line . trim () . split (/ /)
    let count = 0
    for (let i = 0; i < words . length - 1; i ++) {
        for (let j = i + 1; j < words . length; j ++) {
            let [w1, w2] = [words [i], words [j]]
            if (w2 . length > w1 . length) {
                [w1, w2] = [w2, w1]
            }
            if (w1 . startsWith (w2) && w1 . endsWith (w2)) {
                count ++
            }
        }
    }
    console . log (count)
  })
