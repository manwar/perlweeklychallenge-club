class Ch2{
    flipMatrix(m){
        return m.map(function(row){ 
            return row.reverse().map(x => ~x & 1);
        });
    }
}
let ch2 = new Ch2();
console.log(
    ch2.flipMatrix([[1, 1, 0], [1, 0, 1], [0, 0, 0]])
);
console.log(
    ch2.flipMatrix([[1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0]])
);