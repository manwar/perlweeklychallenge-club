use Test2::V0 -target => "Fun";

is $CLASS->convert("05:15 pm"), '17:15', 'Example 1-1';
is $CLASS->convert("05:15pm"),  '17:15', 'Example 1-2';

is $CLASS->convert("19:15"), '07:15pm', 'Example 2-1';

is $CLASS->convert("09:15"), '09:15am', '24hr AM';

done_testing;
