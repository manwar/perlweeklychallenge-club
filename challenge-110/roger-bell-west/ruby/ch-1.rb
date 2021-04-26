#! /usr/bin/ruby

pn=Regexp.new('^ *(\+[0-9]{2}|\([0-9]{2}\)|[0-9]{4}) [0-9]{10} *$')

while line=gets
  if line =~ pn then
    print line
  end
end
