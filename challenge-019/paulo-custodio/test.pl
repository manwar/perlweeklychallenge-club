#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use 5.030;
use Path::Tiny;

is capture("perl perl/ch-1.pl"), <<END;
1901-03
1902-08
1903-05
1904-01
1904-07
1905-12
1907-03
1908-05
1909-01
1909-10
1910-07
1911-12
1912-03
1913-08
1914-05
1915-01
1915-10
1916-12
1918-03
1919-08
1920-10
1921-07
1922-12
1924-08
1925-05
1926-01
1926-10
1927-07
1929-03
1930-08
1931-05
1932-01
1932-07
1933-12
1935-03
1936-05
1937-01
1937-10
1938-07
1939-12
1940-03
1941-08
1942-05
1943-01
1943-10
1944-12
1946-03
1947-08
1948-10
1949-07
1950-12
1952-08
1953-05
1954-01
1954-10
1955-07
1957-03
1958-08
1959-05
1960-01
1960-07
1961-12
1963-03
1964-05
1965-01
1965-10
1966-07
1967-12
1968-03
1969-08
1970-05
1971-01
1971-10
1972-12
1974-03
1975-08
1976-10
1977-07
1978-12
1980-08
1981-05
1982-01
1982-10
1983-07
1985-03
1986-08
1987-05
1988-01
1988-07
1989-12
1991-03
1992-05
1993-01
1993-10
1994-07
1995-12
1996-03
1997-08
1998-05
1999-01
1999-10
2000-12
2002-03
2003-08
2004-10
2005-07
2006-12
2008-08
2009-05
2010-01
2010-10
2011-07
2013-03
2014-08
2015-05
2016-01
2016-07
2017-12
2019-03
END

path("input.txt")->spew(<<END);
In the beginning God created the heavens and the earth. Now the earth was formless and empty,
darkness was over the surface of the deep, and the Spirit of God was hovering over the waters.
And God said, "Let there be light," and there was light. God saw that the light was good, and
he separated the light from the darkness. God called the light "day," and the darkness he called "night."
And there was evening, and there was morning-the first day.
END


is capture("perl perl/ch-2.pl < input.txt"), <<END;
In the beginning God created the heavens and the earth. Now the earth
was formless and empty, darkness was over the surface of the deep, and
the Spirit of God was hovering over the waters. And God said, "Let
there be light," and there was light. God saw that the light was good,
and he separated the light from the darkness. God called the light
"day," and the darkness he called "night." And there was evening, and
there was morning-the first day.
END

unlink "input.txt";
done_testing;

sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \t\v\f\r]*\n/\n/g;
    return $out;
}
