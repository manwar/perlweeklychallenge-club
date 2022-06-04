// Write a script to find out first 10 circular primes having at least 3 digits (base 10).
// A circular prime is a prime number with the property that the number generated at each 
// intermediate step when cyclically permuting its (base 10) digits will also be prime.
//
// Output
// 113, 197, 199, 337, 1193, 3779, 11939, 19937, 193939, 199933

// this script was written by github copilot. it's not very efficient, but it works.

// a function to check if a number is prime
function isPrime(n: number): boolean {
    if (n < 2) {
        return false;
    }
    for (let i = 2; i < n; i++) {
        if (n % i === 0) {
            return false;
        }
    }
    return true;
}

type Result = boolean | number[];
// a function to check if a number is circular prime
// returns false if it is not a circular prime
// returns an array of the circular permutations if it is a circular prime
function isCircularPrime(n: number): Result {
    let circularPermutations: number[] = [];
    let numberString: string = n.toString();
    let numberStringLength: number = numberString.length;
    for (let i = 0; i < numberStringLength; i++) {
        let circularPermutation: string = numberString.slice(i) + numberString.slice(0, i);
        let circularPermutationNumber: number = parseInt(circularPermutation);
        if (!isPrime(circularPermutationNumber)) {
            return false;
        }
        circularPermutations.push(circularPermutationNumber);
    }
    return circularPermutations;
}
// a function to find the first 10 circular primes 
// the prime has to have three digits
function findCircularPrimes(): number[] {
    let circularPrimes: number[] = [];
    let i = 0;

    // store a dictionary of all permutations of the numbers
    let circularPrimesDictionary: { [key: number]: boolean } = {};
    while (circularPrimes.length < 10) {
        // find out if the number is a circular prime and store the result
        let result: Result = isCircularPrime(i);
        // if the result is false, increment the number and continue
        if (result === false) {
            i++;
            continue;
        }
        // if we have not seen the number before, add it to the circular primes array
        if (circularPrimesDictionary[i] === undefined) {
            // if the current number has at least 3 digits add it to the circular primes array
            if (i.toString().length >= 3) {
                circularPrimes.push(i);
            }
        }
        
        // store all the numbers from the result we have seen in the dictionary
        for (let j = 0; j < (result as number[]).length; j++) {
            circularPrimesDictionary[(result as number[])[j]] = true;
        }
        
        i++;
    } 
    return circularPrimes;
}

console.log(findCircularPrimes());