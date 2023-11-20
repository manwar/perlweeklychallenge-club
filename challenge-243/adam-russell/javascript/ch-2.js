class Ch2{
    floorSum(integers){
        let floorSum = 0;
        integers.forEach(function(x){
            integers.forEach(function(y){
                floorSum += Math.floor(x / y)
            });
        });
        return floorSum;
    }
}
let ch2 = new Ch2();
console.log(
    ch2.floorSum([2, 5, 9])
);
console.log(
    ch2.floorSum([7, 7, 7, 7, 7, 7, 7])
);