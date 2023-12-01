class Ch1{
    countSmaller(integers){
        let r = [];
        let i = integers;
        integers.forEach((x) => {
            let smallerCount = integers.map((y) => {return y < x}).
                reduce((accumulator, currentValue) => { 
                    return accumulator + currentValue}, 0);
            r.push(smallerCount);
        });
        return r;
    }
}
let ch1 = new Ch1();
console.log(
    ch1.countSmaller([8, 1, 2, 2, 3])
);
console.log(
    ch1.countSmaller([6, 5, 4, 8])
);
console.log(
    ch1.countSmaller([2, 2, 2])
);