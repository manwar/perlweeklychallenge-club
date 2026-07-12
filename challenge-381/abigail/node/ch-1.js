#!/opt/homebrew/bin/node

let matrix = [];
 
  require ('readline')
. createInterface ({input: process . stdin})
. on              ('line', line => {
    matrix . push (line . split (" ") . map (x => +x))
  })
. on              ('close', () => {
    let N = matrix . length
    let r = true

    for (let i = 0; i < N; i ++) {
        let row = {}
        let col = {}
        for (let j = 0; j < N; j ++) {
            r &&= 1 <= matrix [i] [j] && matrix [i] [j] <= N
            row [matrix [i] [j]] = 1
            col [matrix [j] [i]] = 1
        }
        r &&= Object . keys (row) . length == N &&
              Object . keys (col) . length == N
    }

    console . log (r ? "true" : "false")
})
