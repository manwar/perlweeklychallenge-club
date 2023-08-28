#!/usr/bin/env raku

sub senior-citizens(@arr)
{
  (@arr.grep:{.substr(*-4,*-2) >= 60}).elems
}

say senior-citizens(["7868190130M7522",
		     "5303914400F9211",
		     "9273338290F4010"]);
say senior-citizens(["1313579440F2036",
		     "2921522980M5644"]);

