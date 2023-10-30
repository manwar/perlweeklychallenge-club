const myArray = [-1,1,-6,4,5,-6,1,4,1];
const elementCounts = {};
myArray.forEach(element => {
  elementCounts[element] = (elementCounts[element] || 0) + 1;
});


const objectArray  = Object.entries(elementCounts).sort((a,b) => a[1]-b[1])

let newArray = new Array;
objectArray.forEach(element => {
    while(element[1] > 0 ){
        newArray.push(element[0]);
        element[1] --;
    }

});

console.log(newArray);
