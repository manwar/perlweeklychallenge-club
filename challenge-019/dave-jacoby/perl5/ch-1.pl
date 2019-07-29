#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings
    qw{ experimental::postderef experimental::smartmatch experimental::signatures };

use DateTime;

# The Challenge

#       Write a script to display months from the year 1900 to 2019 
#       where you find 5 weekends i.e. 5 Friday, 5 Saturday and 5 Sunday.

# Let's look at an example of such a month.

#    March 2019
#
#  M   T   W   T   F   S   S 
#                  1   2   3 
#  4   5   6   7   8   9  10 
# 11  12  13  14  15  16  17 
# 18  19  20  21  22  23  24 
# 25  26  27  28  29  30  31 

# A four-weekend month fits in 28 days, so that could be any month,
# but as we see here, we need 3 more days, so we need a 31 day month,
# and it only works if the month starts on Friday.

# 30 days have September (9)
# April (4), June (6) and November (11)
# And February (2) is right out

my @months = (1, 3, 5, 7, 8, 10, 12);

# We only need one DateTime object.
# We'll set the month, day and year as needed

my $date = DateTime->now();
$date->set_day(1);
for my $year ( 1900 .. 2019 ) {
    $date->set_year($year);
    for my $month ( @months ) {
        $date->set_month($month);
        say $date->ymd if 5 == $date->day_of_week;
    }
}

__DATA__

1901-03-01
1902-08-01
1903-05-01
1904-01-01
1904-07-01
1905-12-01
1907-03-01
1908-05-01
1909-01-01
1909-10-01
1910-07-01
1911-12-01
1912-03-01
1913-08-01
1914-05-01
1915-01-01
1915-10-01
1916-12-01
1918-03-01
1919-08-01
1920-10-01
1921-07-01
1922-12-01
1924-08-01
1925-05-01
1926-01-01
1926-10-01
1927-07-01
1929-03-01
1930-08-01
1931-05-01
1932-01-01
1932-07-01
1933-12-01
1935-03-01
1936-05-01
1937-01-01
1937-10-01
1938-07-01
1939-12-01
1940-03-01
1941-08-01
1942-05-01
1943-01-01
1943-10-01
1944-12-01
1946-03-01
1947-08-01
1948-10-01
1949-07-01
1950-12-01
1952-08-01
1953-05-01
1954-01-01
1954-10-01
1955-07-01
1957-03-01
1958-08-01
1959-05-01
1960-01-01
1960-07-01
1961-12-01
1963-03-01
1964-05-01
1965-01-01
1965-10-01
1966-07-01
1967-12-01
1968-03-01
1969-08-01
1970-05-01
1971-01-01
1971-10-01
1972-12-01
1974-03-01
1975-08-01
1976-10-01
1977-07-01
1978-12-01
1980-08-01
1981-05-01
1982-01-01
1982-10-01
1983-07-01
1985-03-01
1986-08-01
1987-05-01
1988-01-01
1988-07-01
1989-12-01
1991-03-01
1992-05-01
1993-01-01
1993-10-01
1994-07-01
1995-12-01
1996-03-01
1997-08-01
1998-05-01
1999-01-01
1999-10-01
2000-12-01
2002-03-01
2003-08-01
2004-10-01
2005-07-01
2006-12-01
2008-08-01
2009-05-01
2010-01-01
2010-10-01
2011-07-01
2013-03-01
2014-08-01
2015-05-01
2016-01-01
2016-07-01
2017-12-01
2019-03-01
