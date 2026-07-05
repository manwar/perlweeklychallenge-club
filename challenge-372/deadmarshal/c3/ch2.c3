module ch2;

import std::io;
import std::collections;

fn int largest_substring(Allocator allocator, String s)
{
	int res = -1;
	HashMap{char, int} m;
	m.init(allocator, s.len);
	defer m.free();

	foreach (int i, char c : s)
	{
		if (m.has_key(c))
		{
			int v = m[c]!!;
			res = max(res, i - v - 1);
		}
		else
		{
			m[c] = i;
		}
	}
	return res;
}

fn int main(String[] args)
{
	mem::@report_heap_allocs_in_scope()
	{
		io::printn(largest_substring(tmem, "aaaaa"));
		io::printn(largest_substring(tmem, "abcdeba"));
		io::printn(largest_substring(tmem, "abbc"));
		io::printn(largest_substring(tmem, "abcaacbc"));
		io::printn(largest_substring(tmem, "laptop"));
	};
	return 0;
}
