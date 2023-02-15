#!/usr/bin/env julia

#=

_________________________________________

AUTHOR: Robert DiCicco

DATE  : 2023-02-09

Challenge 203 Copy Directory ( Julia )

_________________________________________

=#

using Printf



startdir = pwd()



@printf("startdir = %s\n",startdir)

dirs = "a/b/c"

target = "x/y"

println("Creating source directory structure")



for numdir in 1:5

    dpath = dirs * "/" * ('0' + numdir)

    mkpath(dpath)

    println("\tcreated a/b/c")

end



cd(dirs)



println("Creating source files")

files = ["1/1.txt","2/2.txt","3/3.txt","5/5.txt"]



for f in files

    @printf("\t%s/%s\n",dirs,f)

    outfile = open(f,"w")

    close(outfile)

end



println("Creating target directory structure")



cd(startdir)



fulldirpaths=filter(isdir,readdir(startdir * '/' * dirs,join=true))

dirnames=basename.(fulldirpaths)



for outdir in dirnames

    dpath = target * '/' * outdir

    mkpath(dpath)

    @printf("\tcreating %s/%s\n",target,outdir)

end



#=

_________________________________________

SAMPLE OUTPUT

julia .\CopyDirectory.jl

startdir = G:\Projects\Perl\Challenges

Creating source directory structure

        created a/b/c

        created a/b/c

        created a/b/c

        created a/b/c

        created a/b/c

Creating source files

        a/b/c/1/1.txt

        a/b/c/2/2.txt

        a/b/c/3/3.txt

        a/b/c/5/5.txt

Creating target directory structure

        creating x/y/1

        creating x/y/2

        creating x/y/3

        creating x/y/4

        creating x/y/5

_________________________________________

=#
