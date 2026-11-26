#! /usr/bin/lua


function gcd(m0,n0)
   local m,n = m0,n0
   while n ~= 0 do
      m,n = n,m % n
   end
   return m
end

function lcm(m,n)
   return m/gcd(m,n)*n
end

function split(t)
   local cl = {}
   string.gsub(t,
               "(.)",
               function(c)
                  table.insert(cl, c)
               end
   )
   return cl
end

Rational = { n = 1, b = 1 }

function Rational:new(n, d)
   local o = {n = n, d = d}
   self.__index = self
   setmetatable(o,self)
   return o
end

function Rational:stringify()
   local xf = gcd(self.n, self.d)
   if xf > 1 then
      self.n = self.n / xf
      self.d = self.d / xf
   end
   return string.format("%d/%d", self.n, self.d)
end

function Rational:add(other)
   local xd = lcm(self.d, other.d)
   local xn = self.n * xd / self.d + other.n * xd / other.d
   return Rational:new(xn, xd)
end

function fractionaladditionsubstraction(a)
   local terms = {}
   local state = 0
   local n = 0
   local num = 0
   local sign = 0
   local cv = split(a)
   local i = 1
   while i <= #cv do
      if state == 0 then
         if cv[i] == "+" then
            state = 0
            i = i + 1
         elseif cv[i] >= "0" and cv[i] <= "9" then
            sign = 1
            state = 1
            n = cv[i]
            i = i + 1
         elseif cv[i] == "-" then
            sign = -1
            state = 1
            n = 0
            i = i + 1
         end
      elseif state == 1 then
         if cv[i] >= "0" and cv[i] <= "9" then
            n = n * 10 + cv[i]
            i = i + 1
         elseif cv[i] == "/" then
            num = n * sign
            n = 0
            state = 2
            i = i + 1
         end
      elseif state == 2 then
         if cv[i] >= "0" and cv[i] <= "9" then
            n = n * 10 + cv[i]
            i = i + 1
         else
            table.insert(terms, Rational:new(num, n))
            state = 0
         end
      end
   end
   if state == 2 then
      table.insert(terms, Rational:new(num, n))
   end
   local out = Rational:new(terms[1].n, terms[1].d)
   for nn = 2, #terms do
      out = out:add(terms[nn])
   end
   return out:stringify()
end

if fractionaladditionsubstraction("1/2+3/2") == "2/1" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if fractionaladditionsubstraction("-5/2-3/2") == "-4/1" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if fractionaladditionsubstraction("5/3-5/3") == "0/1" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if fractionaladditionsubstraction("10/10-1/10+2/5") == "13/10" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if fractionaladditionsubstraction("1/6+1/6+1/6") == "1/2" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

