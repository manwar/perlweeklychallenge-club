// Input
const S = "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG";
const N = 3;

// Caesar Cipher
const plain = [...'abcdefghijklmnopqrstuvwxyz'];
const cipher = [...plain];
cipher.push(...cipher.splice(0, 26 - N));

S.toLowerCase().split('').forEach(c => {
  if(c === ' ') {
    process.stdout.write(c);
  } else {
    process.stdout.write(cipher[plain.indexOf(c)].toUpperCase());
  }
});
