// Same String

main(["ab", "c"], ["a", "bc"]);
main(["ab", "c"], ["ac", "b"]);
main(["ab", "cd", "e"], ["abcde"]);


function main( arr1, arr2 ) { 

	console.log('Input 1:')
	console.log('@arr1 = (' + arr1 + ')')
	console.log('@arr2 = (' + arr2 + ')')

	const arr1_string = combine_list(arr1)
	const arr2_string = combine_list(arr2)

	const result = compare_strings(arr1_string, arr2_string)

	console.log('Output: ' + result)
	console.log('')

}

function combine_list( arr ) {
	return arr.reduce((acc, str) => acc + str)
} 

function compare_strings( str1, str2 ) {
	return ( str1 == str2 ) ? true : false
}


