#!/usr/bin/env ruby

=begin

_________________________________________

AUTHOR: Robert DiCicco

DATE  : 2023-02-09

Challenge 203 Copy Directory ( Ruby )

_________________________________________

=end



require 'fileutils'

require 'find'



startdir = Dir.pwd

puts("startdir = #{startdir}")

dirs = "a/b/c"

target = "x/y"

puts("Creating source directory structure")



for numdir in 1..5 do

    FileUtils.mkdir_p "#{dirs}/#{numdir}"

end



puts("\tcreated a/b/c")

Dir.chdir(dirs)



puts("Creating source files")

files = ["1/1.txt","2/2.txt","3/3.txt","5/5.txt"]



files.each do |f|

    puts("\t#{dirs}/#{f}")

    out_file = File.new("#{f}", "w")

    out_file.close

end



puts("Creating target directory structure")

Dir.chdir("#{startdir}/#{dirs}")

Find.find(".") do |path|

    next unless File.directory?(path)

    reg_x = /1|2|3|4|5|6|7|8|9/

    outdir = "#{reg_x.match(File.basename(path))}"

    FileUtils.mkdir_p "#{startdir}/#{target}/#{outdir}"

    puts("\tcreating #{target}/#{outdir}")

end



=begin

_________________________________________

SAMPLE OUTPUT

ruby .\CopyDirectory.rb

startdir = G:/Projects/Perl/Challenges

Creating source directory structure

        created a/b/c

Creating source files

        a/b/c/1/1.txt

       a/b/c/2/2.txt

        a/b/c/3/3.txt

        a/b/c/5/5.txt

Creating target directory structure

        creating x/y/

        creating x/y/1

        creating x/y/2

        creating x/y/3

        creating x/y/4

        creating x/y/5

_________________________________________

=end
