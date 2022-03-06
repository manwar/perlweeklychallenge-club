constant @Padovan = 1, 1, 1, { sink $^c; $^a + $^b } ... *;

say @Padovan.grep(&is-prime).squish.head(10);
