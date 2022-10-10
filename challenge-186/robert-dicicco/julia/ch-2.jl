#!/usr/bin/env julia

using Unicode

# AUTHOR: Robert DiCicco
# DATE: 2022-10-10
# Challenge 186 Unicode Makeover ( Julia )

myarr = ["âÊíÒÙ", "ÃÊÍÒÙ"]

for mystr in myarr

  println(Unicode.normalize(mystr, stripmark=true))

end
