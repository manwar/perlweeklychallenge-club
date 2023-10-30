# Given an array, output an array of the running sum.

defmodule Runner do

	def running_sum([head | tail], new_list, sum) do
		sum = sum + head
		running_sum(tail, new_list ++ [sum], sum)
	end

	def running_sum([], new_list, _) do
		new_list
	end
end

IO.puts 'Exercise 1: '
list_of_numbers = [1, 2, 3, 4, 5]
IO.inspect list_of_numbers
IO.inspect Runner.running_sum(list_of_numbers, [], 0)

IO.puts 'Exercise 2: '
list_of_numbers = [1, 1, 1, 1, 1]
IO.inspect list_of_numbers
IO.inspect Runner.running_sum(list_of_numbers, [], 0)

IO.puts 'Exercise 3: '
list_of_numbers = [0, -1, 1, 2]
IO.inspect list_of_numbers
IO.inspect Runner.running_sum(list_of_numbers, [], 0)


