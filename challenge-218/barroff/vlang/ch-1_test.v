module main

[assert_continues]
fn test_lists() {
	assert maximum_product([3, 1, 2]) == 6
	assert maximum_product([4, 1, 3, 2]) == 24
	assert maximum_product([-1, 0, 1, 3, 1]) == 3
	assert maximum_product([-8, 2, -9, 0, -4, 3]) == 216
}
