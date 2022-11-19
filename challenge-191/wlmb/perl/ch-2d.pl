#!/usr/bin/env perl
# Perl weekly challenge 191
# Task 2:  Cute List. Nested iterators.
#
# See https://wlmb.github.io/2022/11/14/PWC191/#task-2-cute-list
use v5.36;
use List::Util qw(all reduce);

sub listit(@set){ # iterator that returns the elements of a set
    sub { return shift @set }
}

sub cute($n){ # return an iterator to generate all cute sequences of length $n
    my @sets;
    for my $position(0..$n-1){
        for(1..$n){ # Build sets of divisors and multiples of $position+1
            push @{$sets[$position]}, $_ if ($position+1)%$_==0 || $_%($position+1)==0;
        }
    }
    sub aux{# closure for an ancilliary iterator constructor
        sub ($pos) { # Returns an iterator for position $pos
	    #The iterator returns a cute subsecuence and a hash of seen values
	    # Return a trivial iterator if beyond end
	    return # trivial iterator beyond position
               sub { state $n=0; return $n++? ():([],{})} if $pos >=@sets;
	    my @set=@{$sets[$pos]};
	    my $it=aux($pos+1); # Iterator for next position
            my $candidates=listit(@set); # iterator for candidates
	    my ($cute, $seen)=$it->(); # initial cute subsequence
	    sub {
                while(1){
                    while(my $candidate=$candidates->()){
                        return([$candidate, @$cute], {$candidate, 1, %$seen})
	                    if !$seen->{$candidate};
                    }
                    return () unless ($cute, $seen)=$it->(); # next subsequence or return
                    $candidates=listit(@set); # reinitalize iterator for candidates
               }
            }
	}
    }
    aux(0); # return iterator for full sequence
}

die << "EOF" unless @ARGV;
Usage: $0 N1 [N2...]
to count the cute orderings of 1..Ni
EOF
warn "Numbers beyond 20 will require patience" unless all {1<=$_<=18} @ARGV;
for(@ARGV){
    my $count=0;
    my $it=cute($_);
    ++$count  while $it->(); # count cute sequences
    say "$_-> $count"; # report
}
