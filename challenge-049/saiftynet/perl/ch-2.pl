#!/usr/env/perl
# Task 2 Challenge 049 Solution by saiftynet
# LRU Cache
# Write a script to demonstrate LRU Cache feature. It should support 
# operations get and set. Accept the capacity of the LRU Cache as 
# command line argument.
# Definition of LRU: An access to an item is defined as a get or 
# a set operation of the item. “Least recently used” item is the 
# one with the oldest access time.
#
# In order to demonstrate the LRU... 1) a test sequence is performed
# that replicates example in description, and 2) an interactive shell
# is opened that allows the user to interact with the LRU Cache

use strict;use warnings;

my (%cache,@recency,$capacity);

# runs test subroutine to esnure matches required spec     
test();

# capacity can be set from command line argument, defaults to 3
$capacity=$ARGV[0]//=3;  
clear(); 

# initialise a dispatch table for parsing inputs. Each command has 
#  1) a regexp to extract parameters, $dispatch{$command}{re}
#  2) an action to perform          , $dispatch{$command}{action}
my %dispatch=(
  set     =>{   # set (key,value) or set key,value: sets a key with a value
    re      =>'\s*\(?\s*\b(.+)\b\s*,\s*\b(.+)\b\s*\)?',
    action =>sub{my ($p1,$p2)=@_;set($p1,$p2)},
  },
  get     =>{   # get (key) or get key : gets key value
    re      =>'\s*\(?\s*\b(.+)\b\s*\)?',
    action  =>sub{my ($p1)=@_;print get($p1),"\n";},
  },	
  cache   =>{   # cache: prints cache in recency order
    re      =>'cache',
    action  =>sub{printCache()},
  },		
  capacity=>{   # capacity can be changed
    re      =>'\s*=?\s*(\d+)',
    action  =>sub{my ($p1)=@_;$capacity=$p1;},
  },	
  lru     =>{   # return least recently used
    re      =>'',
    action  =>sub{print $recency[0],"\n";},
  },	
  mru     =>{   # return most recently used
    re      =>'',
    action  =>sub{print $recency[-1],"\n";},
  },	
  quit    =>{   # quit shell
    re      =>'',
    action  =>sub{exit 0;},
  },
  clear   =>{   # clear the cache
    re      =>'',
    action  =>sub{clear();},
  },	
);

# enter interactive mode for further manipulation of cache
# interaction for users to manipulate and examine stack
print "\n\nInteractive LRU cache started\n
Valid Commands: capacity <capacity>, set(<key>,<value>), get(<key>)
                cache, lru, mru, clear and quit\n";
print "capacity=$capacity\n";

while (1){
   print ">>";                           # prompt
   chomp( my $input = <STDIN>);          # get input
   $input=~/^\s*([a-z]+)([^a-z].*)?$/i;  # extract command and parameters
   my ($command,$params)=($1,$2);
   if (exists $dispatch{$command}){      # if command present in dispatch table
     $params=~/$dispatch{$command}{re}/ if $params;   # separate params
     $dispatch{$command}{action}->($1,$2);# execute disspatach action
   };
};

#### The following 3 routines are the core functions: - get(key),
#### set(key,value) and access(key) 

sub access{
  my $key=shift;          # key being accessed
  push @recency,$key;     # put the key into most recently used 
                                          
  # starting from next most recently used slot, search for key
  # and remove any other occurence of key;
  my $index=$#recency-1;                            
  $index-- while (($index>=0) and ($recency[$index] ne $key));   
  splice @recency, $index, 1 if ($index>=0);
  
  # if capacity exceeded then shift lru out and delete from cache                  
  delete $cache{shift @recency} while ($capacity <@recency);
 }

sub get{                    # get value if key exists else -1
	my $key=shift;
	return -1 unless exists $cache{$key};
	access($key);       # recency updated
	return $cache{$key} # return stored value
}

sub set{                    # set key value pair
	my ($key,$value)=@_;
	$cache{$key}=$value;
	access($key);       # recency updated
}

### The following subroutines are not part of the spec but allow testing

sub test{   # follow the sequence described in the task
	$capacity=3;
	print "Setting 1 to 3 : \n" ;set(1,3);
	print "Setting 2 to 5 : \n" ;set(2,5);
	print "Setting 3 to 5 : \n" ;set(3,7);
	print "Cache now has:-    " ;printCache();
	print "Getting 2 returns : ",get(2),"\n";
	print "Cache now has:-    " ;printCache();
	print "Getting 1 returns : ",get(1),"\n";
	print "Cache now has:-    " ;printCache();
	print "Getting 4 returns : ",get(4),"\n";
	print "Cache now has:-    " ;printCache();
	print "Setting 4 to 9 : \n" ;set(4,9);
	print "Cache now has:-    " ;printCache();
	print "Getting 3 returns : ",get(3),"\n";
}

sub clear{                # clears the cache, and @recency
	%cache=();
	@recency=();
};
sub printCache{           # outputs the recency as in the task description
	print "[Least recently used] ",(join ",",@recency)," [most recently used]\n";
}

