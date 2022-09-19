#!/usr/bin/env raku


my @primes = grep &is-prime, ^Inf;
my @primes-digited = @primes.map( -> $current {                         
  state @buffer;                                                              
  when @buffer[0] andthen .chars == $current.chars {                          
    @buffer.append: $current;                                                   
    Empty                                                                       
  }                                                                           
  my @res = @buffer;                                                          
  @buffer = [$current];                                                       
  @res                                                                        
});
@primes-digited .= skip;
@primes-digited.map({ ([\,] @$_) >>*>> @$_ andthen .flat.sort.Slip })
  andthen .head: 20
  andthen .join: ', '
  andthen .say;
