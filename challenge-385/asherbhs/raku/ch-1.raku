sub uncommon-words($sentence1, $sentence2) {
	do .key if .value == 1 for bag $sentence1.split(' '), $sentence2.split(' ')
}

say uncommon-words 'apple banana apple', 'banana orange';
say uncommon-words 'cat dog', 'bird fish';
say uncommon-words 'the quick brown fox', 'the quick';
say uncommon-words 'hello', 'hello';
say uncommon-words 'blue blue red', 'red green green yellow';
