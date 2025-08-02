#!/usr/bin/env ruby

def count_common(arr1,arr2)
  h = Hash.new(0)
  (arr1 + arr2).each {|e| h[e] += 1 }
  (h.values.select{|e| e == 2}).size
end

p count_common(['Perl','is','my','friend'],
	       ['Perl','and','Raku','are','friend'])
p count_common(['Perl','and','Python','are','very','similar'],
	       ['Python','is','top','in','guest','languages'])
p count_common(['Perl','is','imperative','Lisp','is','functional'],
	       ['Crystal','is','similar','to','Ruby'])

