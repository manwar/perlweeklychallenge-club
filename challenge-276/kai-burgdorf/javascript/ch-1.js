//const hours = [12, 12, 30, 24, 24];
//const hours = [72, 48, 24, 5];
//const hours = [12, 18, 24];

var pairs = [];

hours.forEach((firstSummand, i) => {
  hours.forEach((secondSummand, j) =>  {
    if( j>i && ((firstSummand + secondSummand) % 24) == 0) {
      pairs.push("Pair " + (pairs.length+1) +  ": (" + firstSummand + ", " + secondSummand + ")");
    }
  })
})

console.log("Output: " + pairs.length + "\n" + JSON.stringify(pairs));


