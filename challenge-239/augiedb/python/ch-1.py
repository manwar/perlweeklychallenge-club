from functools import reduce

def show_inputs(arr1, arr2):
	print( "Input: @arr1 = ", arr1 )
	print( "       @arr2 = ", arr2 )

def reduce_string(arr):
	return reduce(lambda x, y: x + y, arr)

def compare_strings(str1, str2):
	return "true" if str1 == str2 else "false"

def show_output(final_answer):
	print( "Output: ", final_answer, "\n" )

def run_everything(arr1, arr2):
	show_inputs(arr1, arr2)
	str1 = reduce_string(arr1)	
	str2 = reduce_string(arr2)
	show_output( compare_strings(str1, str2) )

## Run process with example data
run_everything(["ab", "c"], ["a", "bc"] )
run_everything(["ab", "c"], ["ac", "b"] )
run_everything(["ab", "cd", "e"], ["abcde"] )



