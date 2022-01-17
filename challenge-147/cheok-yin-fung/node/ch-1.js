// The Weekly Challenge 147
// Task 1 Truncatable Prime
// Friday, January 14, 2022 PM07:31:14 HKT

let ltp = new Array();
let recent_ltp = new Array(2,3,5,7);
let new_ltp = new Array();

let prime = new Array(2,3,5,7);



function is_prime(t) {
    for (let k = 0; prime[k] <= Math.sqrt(t); k++) {
        if (t % prime[k] == 0)
            return false;
    }
    return true;
}



function append_primes(max) {
    HERE: for (can = prime[prime.length-1]+1; can <= max ; can++) {
        for (let k=0; prime[k] <= Math.sqrt(can) ;k++) {
            if (can % prime[k] == 0) {
                continue HERE;
            }
        } 
        prime.push(can);
    }

}



function append_ltp(target_size) {
    if (target_size <= ltp.length + recent_ltp.length) {
        ltp = ltp.concat(recent_ltp);
        return;
    }
    for (d = 1; d<=9; d++) {
        for (num of recent_ltp) {
            new_num = parseInt(d + '' + num);
            if (is_prime(new_num)) {
                new_ltp.push(new_num);
            }
        }
    }
    ltp = ltp.concat(recent_ltp);
    recent_ltp = new_ltp;
    new_ltp = new Array();
    append_ltp(target_size);
}



append_primes(1000);
append_ltp(20);
console.log(ltp.slice(0, 20));
