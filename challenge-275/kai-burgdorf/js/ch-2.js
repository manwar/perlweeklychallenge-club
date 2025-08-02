const input = "a1c1e1";
//const input = "a1b2c3d4";
//const input = "b2b";
//const input = "a16z";

//close your eyes from corner cases :D

let charArr = input.split("");
let result = "";

charArr.forEach((singleChar, i) => {
	if(singleChar.match(/[0-9]/g) && i > 0) {
		result += convertToChar(result[i-1], singleChar);
	}
	else {
		result +=singleChar;
	}
});

console.log("input: " + input + " result: " + result);


function convertToChar(predecessor, shiftOffset) {
	return String.fromCharCode((parseInt(predecessor.charCodeAt(0)) + parseInt(shiftOffset)));
}
