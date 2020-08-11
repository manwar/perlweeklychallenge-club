#! /usr/bin/env perl6

# https://docs.perl6.org/type/Proxy

my %hist;

sub memoryvariable($label) is rw
{
  my $val;
  Proxy.new(
        FETCH => method ()
   	{
	  $val
        },
        STORE => method ($new)
    	{
 	  $val = $new;
    	  %hist{$label}.push( Pair(now.Int => $new) );
        },
  );
}

sub history ($label)
{
  return @(%hist{$label}).map( *.value );
}

sub history-timestamp ($label)
{
  return @(%hist{$label}).map({ DateTime.new($_.key).local ~ ": " ~ $_.value }).join("\n");
}

my $x := memoryvariable('x');

$x = 10;

$x = 20;

$x -= 5;

say $x;

say history('x');
say history-timestamp('x');
