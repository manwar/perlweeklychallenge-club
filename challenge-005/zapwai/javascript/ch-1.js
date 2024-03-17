let dict;

const fileInput = document.getElementById('fileInput');
fileInput.addEventListener('change', handleFileUpload);

const ourWord = document.getElementById('ourWord');
ourWord.addEventListener('change', onWordChange);

const ourParagraph = document.getElementById('ourParagraph');

function anagramTime(word) {
    let sorted = dict.slice();
    sorted.forEach( (w, i) => {
	sorted[i] = w.split('').sort().join("");
    });

    let sorted_word = word.split('').sort().join('');

    let anagrams = [];
    for (let i = 0; i < dict.length; i++) {
	if (sorted[i] == sorted_word) {
	    anagrams.push(dict[i]);
	}
    }
    ourParagraph.innerHTML =
	`Input word: ${word}<br>Anagrams: ${anagrams.join(' ')}<br>`;
}

function onWordChange(event) {
    let word = event.target.value;
    anagramTime(word);
}

function handleFileUpload(event) {
    const file = event.target.files[0];
    if (!file) {
	console.error('No file selected');
	return;
    }
    const reader = new FileReader();
    reader.onload = function(e) {
	const content = e.target.result;
	const words = content.split(/\s+/);
	dict = words;
	let word = document.getElementById('ourWord').value;
	anagramTime(word);
    };	
    reader.readAsText(file);    
}

