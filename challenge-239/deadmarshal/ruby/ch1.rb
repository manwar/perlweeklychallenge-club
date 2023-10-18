#!/usr/bin/env ruby

def same_string(arr1,arr2)
  arr1.join == arr2.join
end

p same_string(["ab","c"],["a","bc"])
p same_string(["ab","c"],["ac","b"])
p same_string(["ab","cd","e"],["abcde"])

