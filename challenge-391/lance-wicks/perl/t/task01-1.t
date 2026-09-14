use Test2::V1 -target => 'LWArray', -utf8;
use Test2::Tools::Subtest qw/subtest_buffered/;

subtest_buffered 'Example 1' => sub {
  my @arr1 = (2);
  my @arr2 = (4);
  my $expected = 3.0;

  T2->is($CLASS->mean(@arr1,@arr2),$expected,"The mean should be $expected");
};

subtest_buffered 'Example 2' => sub {
  my @arr1 = (1,2,3);
  my @arr2 = (7,8,9,10);
  my $expected = 7.0;

  T2->is($CLASS->mean(@arr1,@arr2),$expected,"The mean should be $expected");
};

subtest_buffered 'Example 3' => sub {
  my @arr1 = ();
  my @arr2 = (10,20,30,40);
  my $expected = 25.0;

  T2->is($CLASS->mean(@arr1,@arr2),$expected,"The mean should be $expected");
};

subtest_buffered 'Example 4' => sub {
  my @arr1 = (100);
  my @arr2 = (1,2,3,4,5,6,7);
  my $expected = 4.5;

  T2->is($CLASS->mean(@arr1,@arr2),$expected,"The mean should be $expected");
};

subtest_buffered 'Example 5' => sub {
  my @arr1 = (1,2,2);
  my @arr2 = (2,2,3);
  my $expected = 2.0;

  T2->is($CLASS->mean(@arr1,@arr2),$expected,"The mean should be $expected");
};


T2->done_testing;
