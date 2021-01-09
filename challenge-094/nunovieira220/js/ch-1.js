// Input
const words = ['opt', 'bat', 'saw', 'tab', 'pot', 'top', 'was'];

// Group Anagrams
const groups = {};

words.forEach(word => {
  const sortedWord = word.split('').sort().join('');

  if(!groups[sortedWord]) groups[sortedWord] = [];

  groups[sortedWord].push(word);
});

// Output
console.log(Object.values(groups));