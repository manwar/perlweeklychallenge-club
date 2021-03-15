// Unique Subsequence
const counter = (S, T) => {
  if(!T.length || !S.length) return 0;

  const index = S.indexOf(T.substring(0, 1));
  const last = T.length === 1 ? 1 : 0;

  if(index === -1) return 0;

  return last + counter(S.substring(index + 1), T) + counter(S.substring(index + 1), T.substring(1));
}

// Input
const S = 'littleit';
const T = 'lit';

// Output
console.log(counter(S, T));
