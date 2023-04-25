const N = 4;
let grayCode = ['0', '1'];

for (let i = 2; i <= N; i++) {
    let revGrayCode = grayCode.slice().reverse();
    grayCode = grayCode.map(x => '0' + x);
    revGrayCode = revGrayCode.map(x => '1' + x);
    grayCode = grayCode.concat(revGrayCode);
}

grayCode = grayCode.map(x => parseInt(x, 2));
console.log(grayCode);
