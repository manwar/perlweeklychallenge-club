import collections

message = [['H', 'x', 'l', '4', '!'], ['c','e','-','l','o'], ['z','e','6','l','g'], ['H','W','l','v','R'], ['q','9','m','#','o']]

final_word = ''
for j in range(0, len(message)):
	my_list = []
	for i in message:
		my_list.append(i[j])
	
	counter = collections.Counter(my_list)
	final_word += str(counter.most_common()[0][0])

print(final_word)