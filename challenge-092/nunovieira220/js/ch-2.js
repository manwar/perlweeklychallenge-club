// Input
const S = [[1, 2], [3, 7], [8, 10]];
const N = [5, 8];

// Insert Interval

/// In the beginning
if(N[1] < S[0][0]) {
  S.unshift(N);
  console.log(S);
  process.exit(1);
}

/// In the end
if(N[0] > S[S.length - 1][1]) {
  S.push(N);
  console.log(S);
  process.exit(1);
}

/// In the middle
const res = [];
let one = undefined;
let added = false;

const add = pair => {
  res.push(pair);
  one = undefined;
  return true;
}

for(let i = 0; i < S.length; i++) {
  const fst = S[i][0];
  const snd = S[i][1];

  if(one === undefined && N[0] < fst && N[1] < snd && !added) added = add([N[0], N[1]]);
  if(one === undefined && N[0] < fst && N[1] >= fst) one = N[0];
  if(one === undefined) one = fst;

  if(N[0] <= snd && N[1] > snd) {
    if(S[i+1] === undefined || S[i+1][0] > N[1]) added = add([one, N[1]]);
  } else {
    add([one, snd]);
  }
}

// Output
console.log(res);