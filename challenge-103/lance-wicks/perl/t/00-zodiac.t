use Test2::V0 -target => 'Zodiac';

is $CLASS->sign_from_year(1967), 'Fire Goat',    '1967 -> Fire Goat';
is $CLASS->sign_from_year(2017), 'Fire Rooster', '2017 -> Fire Rooster';
is $CLASS->sign_from_year(1938), 'Earth Tiger',  '1938 -> Earth Tiger';
is $CLASS->sign_from_year(1973), 'Water Ox',     '1973 -> Water Ox';
is $CLASS->sign_from_year(2003), 'Water Goat',   '2003 -> Water Goat';

done_testing;
