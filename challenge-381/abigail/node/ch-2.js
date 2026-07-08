#!/opt/homebrew/bin/node
 
  require ('readline')
. createInterface ({input: process . stdin})
. on              ('line', line => {
    let [numbers, min_c, max_c, min, max] = [0, 0, 0]
    line . split (" ") . forEach (number => {
        numbers ++
        if (!min_c || +number < min) {[min_c, min] = [0, +number]}
        if (!max_c || +number > max) {[max_c, max] = [0, +number]}
        if (+number == min) {min_c ++}
        if (+number == max) {max_c ++}
    })
    console . log (numbers - min_c - (min == max ? 0 : max_c))
  })
