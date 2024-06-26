//You are given a sentence, $sentence and list of broken keys @keys.
//
//Write a script to find out how many words can be typed fully.
//
//Example 1
//Input: $sentence = "Perl Weekly Challenge", @keys = ('l', 'a')
//Output: 0
//Example 2
//Input: $sentence = "Perl and Raku", @keys = ('a')
//Output: 1
//
//Only Perl since the other word two words contain 'a' and can't be typed fully.
//Example 3
//Input: $sentence = "Well done Team PWC", @keys = ('l', 'o')
//Output: 2
//Example 4
//Input: $sentence = "The joys of polyglottism", @keys = ('T')
//Output: 2



possibleToType( 'Perl Wekkly Challenge', ['l', 'a']);
possibleToType( 'Perl and Raku', ['a']);
possibleToType( 'Well done Team PWC', ['l', 'o']);
possibleToType( 'The joys of polyglottism', ['T']);



function possibleToType(sentence, brokenKeys) {
        console.log("sentence: " + sentence + " ; Broken Keys: " + JSON.stringify(brokenKeys))
	let counter = 0;
	sentence.split(" ").forEach((word, i) => {
		let hasBrokenKeyLetter = true;
		brokenKeys.forEach((key, i) => {
			if(word.includes(key)) hasBrokenKeyLetter = false;
		})
	        if(hasBrokenKeyLetter) counter++;
	
	})
	console.log("Result: " +counter);
}

