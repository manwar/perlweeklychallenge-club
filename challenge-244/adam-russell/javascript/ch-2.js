class Ch2{
    int2bits(x){
        let bits = [];
        while(x > 0){
            let b = x & 1;
            bits.push(b);
            x = x >> 1;
        }
        return(bits)
    }

    groupHero(integers){
        let group_hero = [];
        let i = integers;
        for(let i = 1; i < 2**integers.length; i++){
            let hero = [];
            let b = this.int2bits(i);
            for(let j = 0; j < b.length; j++){
                if(b[j] == 1)
                    hero.push(integers[j]);
            }
            group_hero.push(Math.max(...hero)**2 * Math.min(...hero));
        }
        return group_hero.reduce((accumulator, currentValue) => { 
            return accumulator + currentValue}, 0);
    }
}
let ch2 = new Ch2();
console.log(
    ch2.groupHero([2, 1, 4])
);