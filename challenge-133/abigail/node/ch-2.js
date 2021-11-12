#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js < input-file
//

let small_primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31]

function factorize (num) {
    let out = []
    small_primes . forEach (prime => {
        while (num % prime == 0) {
            out . push (prime)
            num /= prime
        }
    })

    if (num > 1) {
        out . push (num)
    }

    return out
}


function digit_sum (numbers) {
    let sum = 0
    numbers . forEach (number => {
        while (number > 0) {
            sum += number % 10
            number = Math . floor (number / 10)
        }
    })
    return sum
}


let count  = 0
let number = 1

while (count < 10) {
    let factors = factorize (number)
    if (factors . length > 1 && digit_sum ([number]) == digit_sum (factors)) {
        console . log (number)
        count ++
    }
    number ++
}
