#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 366 Task 1  Count Prefixes
#=============================================================================
# You are given an array of words and a string (contains only lowercase
# English letters).  Write a script to return the number of words in the
# given array that are a prefix of the given string.
# Example 1 Input: @array = ("a", "ap", "app", "apple", "banana"), $str = "apple"
#           Output: 4
#=============================================================================

use v5.42;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================
my $STR = pop @ARGV;
my @ARRAY = @ARGV;
#=============================================================================

exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say cp3($STR, \@ARRAY);

#=============================================================================
sub countPrefix($str, $array)
{
    scalar grep { $str =~ m/^$_/ } $array->@*;
}

sub cp2($str, $array)
{
    scalar grep { substr($str, 0, length($_)) eq $_ } $array->@*;
}

sub cp3($str, $array)
{
    # Generate every possible substring of str, including empty string
    my $regex =  join('|', map { substr($str, 0, $_) } 0 .. length($str));
    #    $logger->debug("str='$str' regex=/$regex/ array=[$array->@*]");

    return scalar grep /^(?:$regex)$/, $array->@*;
}

sub runTest
{
    use Test2::V0;

    my @case = (
        { str => "apple",    array => [ "a", "ap", "app", "apple", "banana" ],
          expect => 4,       desc => "Example 1" },
        { str => "bird",     array => [ "cat", "dog", "fish" ],
          expect => 0,       desc => "Example 2" },
        { str => "hello",    array => [ "hello", "he", "hell", "heaven", "he" ],
          expect => 4,       desc => "Example 3" },
        { str => "coding",   array => [ "", "code", "coding", "cod"],
          expect => 3,       desc => "Example 4" },
        { str => "program",  array => [ "p", "pr", "pro", "prog", "progr", "progra", "program"],
          expect => 7,       desc => "Example 5" },
        { str => "short",    array => [ "longer" ],
          expect => 0,       desc => "Prefix longer than string" },
        { str => "short",    array => [ ],
          expect => 0,       desc => "Empty list of prefix" },
        { str => "",         array => [ qw(a b c) ],
          expect => 0,       desc => "Empty string", },
    );

    my @version = (
        { name => "regex ", func => \&countPrefix },
        { name => "substr", func => \&cp2 },
        { name => "onere ", func => \&cp3 },
    );

    for my $v ( @version )
    {
        for my $c ( @case )
        {
            is( $v->{func}($c->{str}, $c->{array}), $c->{expect}, "$v->{name} $c->{desc}" );
        }
    }

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    my $str = "abcdefghijklmnopqrstuvwxy";
  my $array = [ qw(lorem ipsum dolor sit amet consectetur adipiscing elit e tiam elit neque venenatis ut dolor consectetur iaculis venenatis arcu in in terdum mauris eget neque venenatis dapibus sed finibus varius sapien quis mal esuada fusce libero augue vulputate sit amet faucibus at feugiat at l ectus maecenas vehicula sem metus nullam lobortis massa et est vulputate f acilisis in tempus arcu metus vitae aliquam nibh sodales ac sed vitae era t nec nisl laoreet fringilla aliquam et lobortis purus ut a tristique nisi nec molest ie arcu duis mattis ultrices nisl eget consectetur donec ac lo rem non augue bibendum tincidunt interdum quis velit in gravida metus vitae) ];
    

    cmpthese($repeat, {
            regex  => sub { countPrefix($str, $array) },
            substr => sub { cp2($str, $array) },
            onerex => sub { cp3($str, $array) },
        });
}
