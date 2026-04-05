#!/opt/homebrew/bin/node

  require ('readline')
. createInterface ({input: process . stdin})
. on              ('line', line => {
    let chars = line . trim () . split ("")
    let count_0 = 0
    let count_1 = 0
    chars . forEach (ch => {
        if (ch == '0') {count_0 ++}
        if (ch == '1') {count_1 ++}
    })
    for (let i = 1; i < count_1; i ++) {
        process . stdout . write ("1")
    }
    for (let i = 0; i < count_0; i ++) {
        process . stdout . write ("0")
    }
    process . stdout . write ("1\n")
  })
