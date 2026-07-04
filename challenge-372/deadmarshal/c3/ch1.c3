module ch1;

import std::io;
import std::collections::list;
import std::core::dstring;
import std::core::mem::alloc;

fn String rearrange_spaces(Allocator allocator, String s)
{
	sz count = 0;
	foreach (c : s) if (c == ' ') count++;

	String[] parts = s.split(allocator, " ");
	defer alloc::free(allocator, parts);

	List{String} words;
	words.init(allocator);
	defer words.free();

	foreach (w : parts) if (w.len > 0) words.push(w);

	String[] word_arr = words.to_tarray();
	sz n              = words.len() - 1;

	if (n == 0)
	{
		DString res = dstring::new(allocator, word_arr[0]);
		defer res.free();
		res.append_repeat(' ', count);
		return res.str_view();
	}

	DString spacer = dstring::temp();
	defer spacer.free();
	spacer.append_repeat(' ', count / n);
	DString res = dstring::join(allocator, word_arr, spacer.str_view());

	res.append_repeat(' ', count % n);
	return res.str_view();
}

fn int main(String[] args)
{
	mem::@report_heap_allocs_in_scope()
	{
		io::printfn(rearrange_spaces(mem, "  challenge  "));
		io::printfn(rearrange_spaces(tmem, "coding  is  fun"));
		io::printfn(rearrange_spaces(tmem, "a b c  d"));
		io::printfn(rearrange_spaces(tmem, "  team      pwc  "));
		io::printfn(rearrange_spaces(tmem, "   the  weekly  challenge  "));
	};
	return 0;
}
