#!/opt/homebrew/bin/node

  require ('readline')
. createInterface ({input: process . stdin})
. on              ('line', n => {
    let sf = 1
    for (let i = 1; i <= n; i ++) {
        sf = i * sf + 1 - 2 * (i % 2)
    }
    console . log (sf)
})
