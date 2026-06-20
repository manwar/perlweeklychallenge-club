module ch1;

import std::io;

fn int second_largest_digit(String s)
{
	int a = -1;
	int b = -1;
	foreach (char c : s)
	{
		if (ascii::is_digit(c))
		{
			int v = c - '0';
			if (v > a)
			{
				b = a;
				a = v;
			}
			else if (v > b && v < a)
			{
				b = v;
			}
		}
	}
	return b;
}

fn int main(String[] args)
{
	io::printn(second_largest_digit("aaaaa77777"));
	io::printn(second_largest_digit("abcde"));
	io::printn(second_largest_digit("9zero8eight7seven9"));
	io::printn(second_largest_digit("xyz9876543210"));
	io::printn(second_largest_digit("4abc4def2ghi8jkl2"));
	return 0;
}
