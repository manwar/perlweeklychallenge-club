class Ch1{
    missingMembers(a1, a2){
        let r = [];
        r.push(
            a1.filter(function(x){ 
                return a2.findIndex(function(y){
                    return x === y;
                }) === -1;
            })
        );
        r.push(
            a2.filter(function(x){ 
                return a1.findIndex(function(y){
                      return x === y;
                }) === -1;
            })
        );
        let s = [];
        r.forEach(function(x){
                if(x.length > 0){ 
                    s.push(Array.from(new Set(x)));
                }
        });
        return s;
    }
}
let ch1 = new Ch1();
console.log(
    ch1.missingMembers([1, 2, 3], [2, 4, 6])
);
console.log(
    ch1.missingMembers([1, 2, 3, 3], [1, 1, 2, 2])
);