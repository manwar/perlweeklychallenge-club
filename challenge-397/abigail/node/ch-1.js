#!/opt/homebrew/bin/node

function array_of_int (line) {
    return line . trim () . split (/\s+/) . map (x => +x)
}

function compare (a, b) {return a - b}
 
  require ('readline')
. createInterface ({input: process . stdin})
. on              ('line', line => {
    let numbers = array_of_int (line)
    numbers . sort (compare)

    let sum = 0
    numbers . forEach (num => sum += num)
    let res = sum <= 0 ? 1 : 1 + Math . floor (sum / numbers . length)
    
    numbers . some (num => {
        if (num == res) {
            res ++
        }
        return num > res
    })

    console . log (res)
})
