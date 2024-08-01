//const str = "perl";
//const str = "book";
const str = "good morning";

const vowels = ['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'];
let vowelsCount = 0;

str.split('').map(o => { 
	if(vowels.includes(o)) vowelsCount++;
});

console.log("Output: " + ((vowelsCount % 2) ? "false" : "true" ));
