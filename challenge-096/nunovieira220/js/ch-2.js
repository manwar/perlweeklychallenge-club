// Input
const s1 = 'kitten';
const s2 = 'sitting';

// Edit Distance
const maxLength = Math.max(s1.length, s2.length);

for(let i = 0; i < maxLength; i++) {
  const char1 = s1.charAt(i);
  const char2 = s2.charAt(i);

  if(char1 && char2) {
    console.log(`Replace '${char1}' with '${char2}'`);
  } else if (char1) {
    console.log(`Remove '${char1}' at position ${$i + 1}`);
  } else {
    console.log(`Insert '${char2}' at the end`);
  }
}