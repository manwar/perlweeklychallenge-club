class Ch1{
    reversePairs(integers){
        let r = [];
        for(let i = 0; i < integers.length; i++){
            for(let j = i + 1; j < integers.length; j++){
                if(integers[i] > integers[j] + integers[j])
                    r.push([i, j]);
            }
        }
        return r.length;
    }
}
let ch1 = new Ch1();
console.log(
    ch1.reversePairs([1, 3, 2, 3, 1])
);
console.log(
    ch1.reversePairs([2, 4, 3, 5, 1])
);