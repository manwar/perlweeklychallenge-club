module ch2;

import std::io;

fn int sum(String s) @local
{
	int res;
	foreach (char c : s) res = res * 10 + (c - 'a');
	return res;
}

fn bool sum_of_words(String s1, String s2, String s3)
{
	return sum(s1) + sum(s2) == sum(s3);
}

fn int main(String[] args)
{
	io::printn(sum_of_words("acb", "cba", "cdb"));
	io::printn(sum_of_words("aab", "aac", "ad"));
	io::printn(sum_of_words("bc", "je", "jg"));
	io::printn(sum_of_words("a", "aaaa", "aa"));
	io::printn(sum_of_words("c", "d", "h"));
	io::printn(sum_of_words("gfi", "hbf", "bdhd"));
	return 0;
}
