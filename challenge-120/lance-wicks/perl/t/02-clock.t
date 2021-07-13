use Test2::V0 -target => Clock;

my @tests = (
    { given => '03:10', expected => 35 },
    { given => '04:00', expected => 120 },
);

for (@tests) {
    is $CLASS->angle( $_->{given} ), $_->{expected},
        "angle( '$_->{given}' ) returns: $_->{expected}";
}

subtest 'Hour angle' => sub {
    note 'Hour hand moves .5 degrees per minute';
    my $expected = ( ( 3 * 60 ) + 10 ) * .5;
    my $got      = $CLASS->angle_hour( h => 3, m => 10 );
    is $got, $expected, "Got: $got, expected: $expected";
};

subtest 'Minute angle' => sub {
    note 'Minute hand moves 6 degrees per minute';
    my $expected = 10 * 6;
    my $got      = $CLASS->angle_minute( h => 3, m => 10 );
    is $got, $expected, "Got: $got, expected: $expected";
};

done_testing;
