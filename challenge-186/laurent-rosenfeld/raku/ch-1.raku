sub zip-it (@a, @b) {
    return ~ (@a Z @b).flat;
}
my @tests = <1 2 3>, <a b c>;
say zip-it @tests[0], @tests[1];
say zip-it @tests[1], @tests[0];
