#! /usr/bin/env perl


use v5.22;

#TASK: write a script to generate the first 10 weak and strong
#prime numbers

#we start off our list of primes with 2, so that 1 isn't included
my @primes = (2);

#a function to add primes to the list. Acts as a generator by
#remembering $bottom, the number up til which we have primes for
sub generate_primes_till {
  my $max = shift;
  state $bottom = 3;
  for ($bottom .. $max) {
    push @primes, $_ if is_prime($_)
  }
  $bottom = $max;
}

#checks if divisible by any other prime
sub is_prime {
  my $number = shift;
  for (@primes) {
    #bail out on first number with no remainder
    return 0 unless $number % $_; 
  }
  #any truthy value would do, but hey, it's self documenting.
  #... he said as he documents it
  return 'prime'
}

#an interface to our generator. Returns the prime at number n if it exists,
#and otherwise expands the list until there is a prime at that number
sub p {
  my $n = shift;
  state $top = 0;
  #if there's an entry at this number, then return it
  return $primes[$n] if $primes[$n];
  #otherwise, generate more numbers and then return it
  until ($primes[$n]) {
    generate_primes_till ($top+=1000)
  }
}

sub is_strong {
  my $n = shift;
  p($n) > ( p($n-1) + p($n+1) ) /2
}

sub is_weak {
  my $n = shift;
  p($n) < ( p($n-1) + p($n+1) ) /2
}

my @strongs;
my $n;
until (@strongs == 10 ) {
  $n++;
  push @strongs, p($n) if is_strong $n;
}

$n = 0;
my @weaks;
until (@weaks == 10 ) {
  $n++;
  push @weaks, p($n) if is_weak $n;
}

say <<"OUTPUT";
The strong numbers are:
@strongs

The weak numbers are:
@weaks

OUTPUT
