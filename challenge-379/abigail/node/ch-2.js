#!/opt/homebrew/bin/node
 
  require ('readline')
. createInterface ({input: process . stdin})
. on              ('line', line => {
    let [base, limit] = line . split (" ") . map (x => +x)
    for (let n = 0; n <= limit; n ++) {
        let size = 0
        for (let n_c = n; n_c > 0; n_c = Math . floor (n_c / base)) {
            size ++
        }
        let sum = 0
        for (let n_c = n; n_c > 0; n_c = Math . floor (n_c / base)) {
            sum += (n_c % base) ** size
        }
        if (sum == n) {
            process . stdout . write (sum . toString () + " ")
        }
    }
    process . stdout . write ("\n")
})
