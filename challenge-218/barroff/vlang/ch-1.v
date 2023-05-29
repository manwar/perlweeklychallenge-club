module main

fn maximum_product(numbers []int) int {
	mut max_prod := numbers[0] * numbers[1] * numbers[2]
	mut temp_prod := 1
	for x in 0 .. numbers.len - 2 {
		for y in x + 1 .. numbers.len - 1 {
			for z in y + 1 .. numbers.len {
				temp_prod = numbers[x] * numbers[y] * numbers[z]
				if temp_prod > max_prod {
					max_prod = temp_prod
				}
			}
		}
	}
	return max_prod
}

fn main() {
}
