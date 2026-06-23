sub sum-of-words(Str:D $str1, Str:D $str2, Str:D $str3) {
	my &n = *.trans: 'a'..'j' => '0'..'9';
	n($str1) + n($str2) == n($str3)
}

say sum-of-words 'acb', 'cba',  'cdb';
say sum-of-words 'aab', 'aac',  'ad';
say sum-of-words 'bc',  'je',   'jg';
say sum-of-words 'a',   'aaaa', 'aa';
say sum-of-words 'c',   'd',    'h';
say sum-of-words 'gfi', 'hbf',  'bdhd';

