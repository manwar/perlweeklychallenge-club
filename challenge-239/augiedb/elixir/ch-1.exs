##
## You are given two arrays of strings.
##
## Write a script to find out if the word created
## by concatenating the array elements is the same.
##
## Example: ("ab", "c") and ("a", "bc") are the same.
##          ("ac", "b") and ("ab", "c") are not.
##
##
## LIMITS:
## Only two arrays to compare.
## But they can have as many string parts as they'd like, from 1 to some huge number.
##

# Two arrays?  How about a tuple of lists!

defmodule SameString do

	def show_inputs({list1, list2}) do
		IO.puts "Input: List1 = "
		IO.inspect list1

		IO.puts "Input: List2 = "
		IO.inspect list2

		{list1, list2}
	end

	def combine_lists({list1, list2}) do

		string1 = reduce_string(list1)
		string2 = reduce_string(list2)

		{string1, string2}		

	end

	def reduce_string( list_of_strings ) do
		
		Enum.reduce(list_of_strings, "", fn characters, acc ->
			acc <> characters
		end)
		
	end

	def compare_strings({string1, string1}), do: true
	def compare_strings({_, _}), do: false

	def show_output(true), do: IO.puts "Output: True"
	def show_output(false), do: IO.puts "Output: False"

	def run_everything(tuple_of_lists) do

		tuple_of_lists
		|> show_inputs()
		|> combine_lists()
		|> compare_strings()
		|> show_output()

	end
end




SameString.run_everything( {["ab", "c"], ["a", "bc"]} )
IO.puts ''
SameString.run_everything( {["ab", "c"], ["ac", "b"]} )
IO.puts ''
SameString.run_everything( {["ab", "cd", "e"], ["abcde"]} )



