module ch1;

import std::io;
import std::core::mem::alloc;

fn bool? same_row_column(Allocator allocator, int[][] m)
{
	sz n = m.len;
	foreach (row : m)
	{
		bool[] h = alloc::new_array_try(allocator, bool, n + 1)!;
		defer alloc::free(allocator, h);
		foreach (num : row)
		{
			if (num < 1 || num > n || h[num]) return false;
			h[num] = true;
		}
	}

	for (sz col = 0; col < n; col++)
	{
		bool[] h = alloc::new_array_try(allocator, bool, n + 1)!;
		defer alloc::free(allocator, h);
		foreach (row : m)
		{
			int num = row[col];
			if (num < 1 || num > n || h[num]) return false;
			h[num] = true;
		}
	}
	return true;
}

fn int main(String[] args)
{
	int[][] m1 = { { 1, 2, 3, 4 }, { 2, 3, 4, 1 }, { 3, 4, 1, 2 }, { 4, 1, 2, 3 } };
	int[][] m2 = { { 1 } };
	int[][] m3 = { { 1, 2, 5 }, { 2, 5, 1 } };
	int[][] m4 = { { 1, 2, 3 }, { 1, 2, 3 }, { 1, 2, 3 } };
	int[][] m5 = { { 1, 2, 3 }, { 3, 2, 1 }, { 3, 2, 1 } };
	io::printn(same_row_column(tmem, m1))!!;
	io::printn(same_row_column(tmem, m2))!!;
	io::printn(same_row_column(tmem, m3))!!;
	io::printn(same_row_column(tmem, m4))!!;
	io::printn(same_row_column(tmem, m5))!!;
	return 0;
}
