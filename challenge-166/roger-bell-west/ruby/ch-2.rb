#! /usr/bin/ruby

require 'set'

def kdd(dirlist0)
  dirlist = dirlist0.sort
  fx = Hash.new
  dirlist.each do |d|
    Dir.new(d).each do |entry|
      nn = entry
      if File.directory?(d + "/" + entry) then
        nn += '/'
      end
      if !fx.has_key?(nn) then
        fx[nn]=Set.new
      end
      fx[nn].add(d)
    end
  end
  mm = dirlist.length
  out = [dirlist]
  fx.keys.sort.each do |f|
    if !(fx[f].length == mm) then
      l = []
      dirlist.each do |d|
        if fx[f].include?(d) then
          l.push(f)
        else
          l.push("")
        end
      end
      out.push(l)
    end
  end
  return out
end

def tabular(d)
  columnlength = []
  d.each do |row|
    row.each_with_index do |col,i|
      while columnlength.length <= i do
        columnlength.push(0)
      end
      columnlength[i] = [columnlength[i],col.length].max
    end
  end
  fs = columnlength.collect{|i| "%-" +  i.to_s + "s"}.join(" | ")
  d.each do |row|
    puts(fs % row)
  end
end

tabular(kdd(["dir_a","dir_b","dir_c"]))
