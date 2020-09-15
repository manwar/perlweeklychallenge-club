//
// Exercise:
//     You are given a positive integer $N.
//     Write a script to find out all possible combination of Fibonacci
//     Numbers required to get $N on addition.
//
//     You are NOT allowed to repeat a number. Print 0 if none found.
//

//
// Note:
//    The "Print 0 if none found." is irrelevant. There is always at
//    least one way to write any positive integer as a sum of distinct
//    Fibonacci Numbers. (Zeckendorf's theorem states: "very positive
//    integer can be represented uniquely as the sum of one or more
//    distinct Fibonacci numbers in such a way that the sum does not
//    include any two consecutive Fibonacci numbers")
//

//
// Read the input number from STDIN
//
let fs = require ("fs");
let N  = +fs . readFileSync (0) . toString () . trim ();

//
// Generate a list of Fibonacci numbers, starting with (1, 2),
// up to the target number. Store this in FIB.
//
let FIB = [1, 2];
while (FIB [FIB . length - 1] + FIB [FIB . length - 2] < N) {
    FIB . push (FIB [FIB . length - 1] + FIB [FIB . length - 2]);
}

//
// Recursive function to find the sums. First argument is the target
// number, second argument is the index of smallest number which can
// be used. 
//
function solutions (target, index = 0) {
    let output = [];
    //
    // Iterate over the list of Fibonacci numbers, looking for
    // candidates. We're starting with the given index.
    //
    for (let i = index; i < FIB . length; i ++) {
        let fib = FIB [i];
        if (fib > target) {
            //
            // If the candidate is larger than the target number,
            // we can stop looking, as each subsequent number will
            // be larger.
            //
            break;
        }
        if (fib == target) {
            //
            // If the candidate is equal to the target number, 
            // then it's a trivial solution (a sum of 1 number).
            // Add it to the list of possibilities, and stop
            // searching.
            //
            output . push ([fib]);
            break;
        }
        else {
            //
            // Find solutions for the difference between the
            // candidate and the target number, with the restriction
            // that each number in that sum is larger than the numbers
            // used so far.
            //
            let rec_solutions = solutions (target - fib, i + 1);

            //
            // For each solution found in recursion, we have a solution
            // for this call, by adding the candidate to it.
            //
            for (let j = 0; j < rec_solutions . length; j ++) {
                output . push ([fib] . concat (rec_solutions [j]));
            }
        }
    }
    return output;
}

//
// Find the solutions
//
let sols = solutions (N);

//
// And print the results
//
for (let i = 0; i < sols . length; i ++) {
    console . log (sols [i] . join (" + ") + " = " + N);
}
