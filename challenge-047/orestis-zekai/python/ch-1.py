# For sake of simplicity, we will consider that MMMCMXCIX is the largest number we can get
# This maps to 3999

# Helper dicitonairies
roman_dict = {'I': 1, 'V': 5, 'X': 10, 'L': 50, 'C': 100, 'D': 500, 'M': 1000}

def romanToArab(number):
	arabNumber = 0

	for i in range(0, len(number)):
		letter = str(number[i])
		value = roman_dict[letter]

		if (i < len(number) - 1):
			if (value < roman_dict[str(number[i+1])]):
				arabNumber -= value
			else:
				arabNumber += value
		else:
			arabNumber += value

	return arabNumber


def arabToRoman(number):
	conv = [[1000, 'M'], [900, 'CM'], [500, 'D'], [400, 'CD'], [100, 'C'], [90, 'XC'], [50, 'L'], [40, 'XL'], [10, 'X'], [9, 'IX'], [5, 'V'], [4, 'IV'], [1, 'I']]

	result = ''
	for denom, roman_digit in conv:
		result += roman_digit*int((number/denom))
		number %= denom

	return result

# Main
roman_input1 = 'MDCCCXCVII'
roman_input2 = 'IC'

arabInput1 = romanToArab(roman_input1)
arabInput2 = romanToArab(roman_input2)


print('The roman number ' + roman_input1 + ' converts to ' +  str(arabInput1))
print('The roman number ' + roman_input2 + ' converts to ' +  str(arabInput2))

arabSum = arabInput1 + arabInput2
print('\nThe sum of the two numbers in arab is ' + str(arabSum) + '\n')

if (arabSum > 3999):
	print('The sum is greater than 3,999 so it will not be converted')
else:
	romanSum = arabToRoman(arabSum)
	print('The sum of the two numbers in roman is ' + romanSum)