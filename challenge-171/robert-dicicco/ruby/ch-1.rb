#!ruby.exe

# AUTHOR: Robert DiCicco
# DATE: 2022-06-28
# Challenge 171 Abundant Numbers ( Ruby )

def divisors(n)
  (1..n).select { |i| n % i == 0 }
end

n = 1;

count = 0;

while count < 20

  a = divisors(n);

  a.pop

  mySum = a.sum

  if ((mySum > n) && (n % 2 == 1))

     print "#{n} "

     count += 1

   end

   n += 1

end

puts " "
