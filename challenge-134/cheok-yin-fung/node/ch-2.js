// The Weekly Challenge 134
// Task 2 Distinct Terms Count
// Usage: $ nodejs ch-2.js m n

// Note: This is my first JavaScript/Node.js program.  

// https://stackoverflow.com/questions/9724412/
//   how-do-i-declare-two-dimensional-arrays-in-javascript

// https://nodejs.org/en/knowledge/command-line/
//   how-to-parse-command-line-arguments/

// https://www.w3schools.com/jsref/jsref_sort.asp

var myArgs = process.argv.slice(2);

var m = myArgs[0];
var n = myArgs[1];
var myArr = new Array();
var myNum = new Array();

for (var i = 0; i < m; i++) {
    myArr[i] = [];
    for (var j = 0; j < n; j++) {
        myArr[i][j] = (i+1)*(j+1);
        myNum.push(myArr[i][j]);
    }
}

var temp = myArr[0];
console.log("   ", "x" ,"\t| ", temp.join("\t"));
console.log("");
console.log("");
for (var i = 0; i < m; i++) {
    var temp = myArr[i];
    console.log("   ", i+1 ,"\t| ", temp.join("\t"));
}

myNum.sort(function(a, b){return a-b});
var myDistinctNum = new Array();
myDistinctNum.push(1);
for (var k = 1; k < myNum.length; k++) {
    if (myNum[k-1] != myNum[k]) {
        myDistinctNum.push(myNum[k]);
    }
}

console.log("");
console.log("");
console.log("Distinc Terms");
console.log(myDistinctNum.join(", "));
console.log("Count: ", myDistinctNum.length);

/* Output:

$ nodejs ch-2.js 6 5
    x 	|  1	2	3	4	5


    1 	|  1	2	3	4	5
    2 	|  2	4	6	8	10
    3 	|  3	6	9	12	15
    4 	|  4	8	12	16	20
    5 	|  5	10	15	20	25
    6 	|  6	12	18	24	30


Distinc Terms
1, 2, 3, 4, 5, 6, 8, 9, 10, 12, 15, 16, 18, 20, 24, 25, 30
Count:  17                      */
