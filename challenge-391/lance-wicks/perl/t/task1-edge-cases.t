use Test2::V1 -target => 'LWArray', -utf8;
use Test2::Tools::Subtest qw/subtest_buffered/;

subtest_buffered 'Single element' => sub {
  my @arr1 = (5);
  my @arr2 = ();
  my $expected = 5.0;

  T2->is($CLASS->mean(@arr1,@arr2),$expected,"The mean should be $expected");
};

subtest_buffered 'Even count of 6' => sub {
  my @arr1 = (1,2,3);
  my @arr2 = (4,5,6);
  my $expected = 3.5;

  T2->is($CLASS->mean(@arr1,@arr2),$expected,"The mean should be $expected");
};

subtest_buffered 'Odd count of 3' => sub {
  my @arr1 = (1,2,3);
  my @arr2 = ();
  my $expected = 2.0;

  T2->is($CLASS->mean(@arr1,@arr2),$expected,"The mean should be $expected");
};

subtest_buffered 'Odd count of 5' => sub {
  my @arr1 = (1,2,3,4,5);
  my @arr2 = ();
  my $expected = 3.0;

  T2->is($CLASS->mean(@arr1,@arr2),$expected,"The mean should be $expected");
};

subtest_buffered 'Odd count of 9' => sub {
  my @arr1 = (10,20,30,40,50);
  my @arr2 = (55,60,65,70);
  my $expected = 50.0;

  T2->is($CLASS->mean(@arr1,@arr2),$expected,"The mean should be $expected");
};

subtest_buffered 'Unsorted input' => sub {
  my @arr1 = (9,1);
  my @arr2 = (5,3,7);
  my $expected = 5.0;

  T2->is($CLASS->mean(@arr1,@arr2),$expected,"The mean should be $expected");
};

subtest_buffered 'Empty input returns undef without warnings' => sub {
  my @arr1 = ();
  my @arr2 = ();
  my @warnings;

  local $SIG{__WARN__} = sub { push @warnings, @_ };

  my $got = $CLASS->mean(@arr1,@arr2);

  T2->is($got, undef, "Empty input should return undef");
  T2->is(\@warnings, [], "Empty input should not emit warnings");
};

subtest_buffered 'Negative numbers odd count' => sub {
  my @arr1 = (-3,-1);
  my @arr2 = (2);
  my $expected = -1.0;

  T2->is($CLASS->mean(@arr1,@arr2),$expected,"The mean should be $expected");
};

subtest_buffered 'Negative numbers even count' => sub {
  my @arr1 = (-5,-1);
  my @arr2 = (3,7);
  my $expected = 1.0;

  T2->is($CLASS->mean(@arr1,@arr2),$expected,"The mean should be $expected");
};

T2->done_testing;
