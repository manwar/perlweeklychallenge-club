#!/usr/env perl

# PerlWeeklyChallenge 41-1
# Attractive number:  - a number that has a prime number of prime factors:
# Task:-  identify first 20 attractive numbers

# Identifying number of primes factors may be done by repeated testing of
# a series of increasing potential factors.  This task can be intensive
# unless rationalised somehow. The actual number of steps can be reduced by 
#
# 1) setting a limit for search: square (root of number + 1)
# 2) search only odd numbers after 2, or search only known prime numbers
# 3) reducing limit after every factor identified.
#
# The search can be made even faster, if one caches: -
# 1) the discovered factors
# 2) the discovered primes
# this increase in performance happens at the expense of memory and depends on
# preloading 
# 
# The following solution offered, demonstrates 3 methods of factorisation.
# Each method is encapsulated in a hash which offers also functions
# factorise(), isPrime(), numberOfFactors() and isAttractive()
# The first method offers no caching, second method caches factors and 
# third caches the primes and the factors. The first requires no preloading
# the second and third preload.  All three methods are tested using benchmark(); 
# NOTE use strict and use warnings are not used becaiuse of the naughty way
# the solution encapsulates each method of factorisation inside a hash 

initialise();
getAttractive(20,"method2");
benchmark();

sub getAttractive{                     # gets attractive numbers 
	my $n=shift;                       # how many to get
	$method=shift //"method1";         # which method to use or use method1
	print "Using $method the first $n attractive numbers are:-\n"; 
	
	my $candidate=0;                   # number to test for attractiveness
	
	while ($n--) {
		                               # increment $candidate until attractive found
		while (!${$method}{isAttractive}->(++$Candidate)){};   
		                               # display attarctive numbers and factors
		print "$Candidate is attractive; Factors are ",
			   (join ",",(defined ${$method}{factors})    ?   # if a cache of factors exists
			         @{${$method}{factors}  ->[$Candidate]} : # retrieve from cache or
			         @{${$method}{factorise}->($Candidate)} ),# just factorise again
					  "\n";			  
	}
}


sub initialise{
	
# Method1 caches nothing. The factorise function return the list of factors, or 
# just the number itself if it is prime 

	%method1=(                    # "our" used to make it available
	                                  # outsibe the initialise subroutine
	   factorise=>sub {
		   my $wn=$number=shift;      # the number to test is loaded
		   my @factorsList=();        # the aray of factors found
		   my $test=2;                # start search with 2 as a factor
		   my $limit=sqrt($wn+1);        # continue to a reasonable limit 
		   while ($test < $limit){    # until limit passed
			 if  ($wn % $test){       # if not a factor (i.e. $wn % $test is not zero
				 $test++;             # test next number
				 $test++ unless $test==3;  # ensure that after 2 only odd numbers are tested
			 }
			 else{                    # factor found
			  push @factorsList,$test;# store factor in our list
			  $wn=$wn/$test;          # and factorise the rest...
			  $limit=sqrt($wn+1)      # ...resetting limit accordingly
			 }
		   } 
		  return [@factorsList,$wn];  # return all factors found (including the last prime)
	  },
	  
	  isPrime=>sub{                   # all methods retun the number if no factors are found 
		my $t=shift;
		return 0 if $t<2;             # 0 and 1 are not prime numbers
		return $method1{ numberOfFactors}->($t)==1?1:0;
	  },
	  
	  numberOfFactors=>sub{           # list of factors obtained by factorise
		my $t=shift;
		return scalar @{$method1{factorise}->($t)};
		},

	  isAttractive=>sub {             # tests that numberOfFactors() isPrime()
			my $t=shift;
			return $method1{isPrime}->( $method1{numberOfFactors}->( $t ) );
		},
	  
	);

# Method 2 caches the factors.  Because the factors of previously tested numbers are
# retained only the smallest factor is required, and it merely retrieves the rest 
# from the cache

	%method2=(
	   factorise=>sub {
		   my $number=shift;           # the number to test is loaded
		                               # if number already has ached factors, retieve from cache
		   return  $method2{factors}->[$number] if (defined $method2{factors}->[$number]) ;
		   my $test=2; $limit=sqrt($number+1);  # as before start with 2 and set limits
		   while (($test < $limit)&&($number % $test)){
				 $test++;
				 $test++ unless $test==3;
		   }
		   if ($test<$limit){           # found the smallest prime factor.
			                            # Because of caching, all the other factors have 
			                            # already been found, no need to search.
			   $method2{factors}->[$number]=  [$test,@{$method2{factors}->[$number/$test]}]
		   }
		   else{                        #otherwise this is a prime number, store in cache
			   $method2{factors}->[$number]=  [$number];  
		   }
		   return  $method2{factors}->[$number];
		},
		
	  isPrime=>sub{
		my $t=shift;
		return 0 if $t<2;
		return $method2{numberOfFactors}->($t)==1?1:0;
	  },
	  
	  numberOfFactors=>sub{              # retrieve from cache
		my $t=shift;
		return scalar @{$method2{factors}->[$t]};
		},

	   isAttractive=>sub{                # tests that numberOfFactors() isPrime()
			my $t=shift;
			return $method2{isPrime}->( $method2{numberOfFactors}->( $t ) );
		},
	  
	  factors=>[],                       # cache of factors 
	);


# Method 3 caches factors and primes.
# the primes cache is a hash, with each prime stored as key, with next key as its value
# e.g 2=>3,3=>5,5=>7,7=>11,11=>-1,largest=>11. this allows quick retrieval of the next
# found poetntial prime factor.
 
   %method3=(
	   factorise=>sub{
		   my $number=shift;
		   return  $method3{factors}->[$number] if (defined $method3{factors}->[$number]) ;
		   my $test=2; my $limit=sqrt($number+1);
		   while (($test < $limit)&&($number % $test)){
				 $test=$method3{primes}->{$test};        # test larger and larger primes
		   }
		   if (($number % $test)||($number/$test ==1)){   # no old prime factor found 
				   # number must be a new prime larger than one previously encountered
				   # this is stored in a hash, replacing previous largest prime
				   # this method of setting multiple values in a hash is not possible with "strict"
			   @method3{primes}->{$number,$method3{primes}->{"largest"},{"largest"} }=(-1,$number,$number);
			   $method3{factors}->[$number]= [$number];
		   }
		   else{
			   $method3{factors}->[$number]=[$test,@{$method3{factors}->[$number/$test]}]; 
		   }
		   return $method3{factors}->[$number];
	   },
	   
	  isPrime=>sub{                                     # check primes from the hash cache
		my $t=shift;
		return 0 if $t<2;
		return defined $method3{primes}->{$t}?1:0;
	  },
	  
	  numberOfFactors=>sub{                   
		my $t=shift;
		return scalar @{$method3{factors}->[$t]};        # check factors from the cache array
		},

	   isAttractive=>sub{                # tests that numberOfFactors() isPrime()
			my $t=shift;
			return $method3{isPrime}->( $method3{numberOfFactors}->( $t ) );
		},
		
	  primes =>{2=>3,3=>5,5=>7,7=>11,11=>-1,largest=>11},
	  factors=>[],
	);

	for my $method ("method2","method3"){
		for (1..100){
		  ${$method}{factorise}->($_)
		}
	}
}

# This routine benchmarks the three methods twice, demonstrating the
# effectiveness of caching at first and subsequent passes.
sub benchmark{
	use Time::HiRes qw ( time);
	my $start;
	for (1,2){
		print "Benchmark pass $_\n";
		for my $end (1000,10000,100000){
			
			for my $method (1..3){
				$start=time();
				for (1..$end){
				  ${"method$method"}{factorise}->($_)
				}
				${"duration$method"}= int (1000*(time()-$start));
			}
			print "With $end factorisations: Method1 $duration1 ms   Method2 $duration2 ms  Method3 $duration3 ms \n";
		}	
	}
}



# output
#
#	Using method2 the first 20 attractive numbers are:-
#	4 is attractive; Factors are 2,2
#	6 is attractive; Factors are 2,3
#	8 is attractive; Factors are 2,2,2
#	9 is attractive; Factors are 3,3
#	10 is attractive; Factors are 2,5
#	12 is attractive; Factors are 2,2,3
#	14 is attractive; Factors are 2,7
#	15 is attractive; Factors are 3,5
#	18 is attractive; Factors are 2,3,3
#	20 is attractive; Factors are 2,2,5
#	21 is attractive; Factors are 3,7
#	22 is attractive; Factors are 2,11
#	25 is attractive; Factors are 5,5
#	26 is attractive; Factors are 2,13
#	27 is attractive; Factors are 3,3,3
#	28 is attractive; Factors are 2,2,7
#	30 is attractive; Factors are 2,3,5
#	32 is attractive; Factors are 2,2,2,2,2
#	33 is attractive; Factors are 3,11
#	34 is attractive; Factors are 2,17
#	Benchmark pass 1
#	With 1000 factorisations: Method1 4 ms   Method2 2 ms  Method3 3 ms 
#	With 10000 factorisations: Method1 58 ms   Method2 35 ms  Method3 26 ms 
#	With 100000 factorisations: Method1 934 ms   Method2 397 ms  Method3 233 ms 
#	Benchmark pass 2
#	With 1000 factorisations: Method1 3 ms   Method2 0 ms  Method3 0 ms 
#	With 10000 factorisations: Method1 49 ms   Method2 5 ms  Method3 5 ms 
#	With 100000 factorisations: Method1 895 ms   Method2 54 ms  Method3 51 ms 
