module ch2;

import std::io;

fn int smaller_greater_element(int[] arr)
{
	int res;
	int mi = int::max;
	int mx = int::min;
	foreach (n : arr)
	{
		mi = min(mi, n);
		mx = max(mx, n);
	}
	foreach (n : arr) if (mi < n && n < mx) res++;
	return res;
}

fn int main(String[] args)
{
	io::printn(smaller_greater_element({ 2, 4 }));
	io::printn(smaller_greater_element({ 1, 1, 1, 1 }));
	io::printn(smaller_greater_element({ 1, 1, 4, 8, 12, 12 }));
	io::printn(smaller_greater_element({ 3, 6, 6, 9 }));
	io::printn(smaller_greater_element({ 0, -5, 10, -2, 4 }));
	return 0;
}
