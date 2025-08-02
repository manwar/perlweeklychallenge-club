let dict;

const fileInput = document.getElementById('fileInput');
fileInput.addEventListener('change', handleFileUpload);

const ourParagraph = document.getElementById('ourParagraph');

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
	mostAnagrams();
    };	
    reader.readAsText(file);    
}

function mostAnagrams() {
    let sorted = dict.slice();
    sorted.forEach( (w, i) => {
	sorted[i] = w.split('').sort().join("");
    });
    sorted.sort();

    let maxnum = 0;
    let maxword = "";

    let flag = 0;
    let cnt = 0;
    for (let i = 0; i < sorted.length; i++) {
	if (flag == 1) {
	    if (sorted[i+1] != sorted[i]) {
		flag = 0;
		cnt += 1;
		if (maxnum < cnt) {
		    maxnum = cnt;
		    maxword = sorted[i];
		}
		cnt = 0;
	    }
	    cnt += 1;
	} else {
	    if (sorted[i + 1] == sorted[i]) {
		cnt += 1;
		flag = 1;
	    }
	}
    }
    
    ourParagraph.innerHTML =
	`Max number of anagrams: ${maxnum}<br>
Characters: ${maxword}<br>`;
}
