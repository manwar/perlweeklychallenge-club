#! /usr/bin/lua

Rect = {x1 = 0, y1 = 0, x2 = 0, y2 = 0, a = {}, b = {}}

function Rect:new(a,b)
   local o = {}
   self.__index = self
   setmetatable(o,self)
   o.x1=math.min(a[1],b[1])
   o.x2=math.max(a[1],b[1])
   o.y1=math.min(a[2],b[2])
   o.y2=math.max(a[2],b[2])
   return o
end

function Rect:area()
   return (self.x2-self.x1)*(self.y2-self.y1)
end

function Rect:overlap(other)
   local x=math.max(0,math.min(self.x2,other.x2)-math.max(self.x1,other.x1))
   local y=math.max(0,math.min(self.y2,other.y2)-math.max(self.y1,other.y1))
   return x*y
end

function Rect:fullarea(other)
   return self:area()+other:area()-self:overlap(other)
end

if Rect:new({-1,0},{2,2}):fullarea(Rect:new({0,-1},{4,4})) == 22 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if Rect:new({-3,-1},{1,3}):fullarea(Rect:new({-1,-3},{2,2})) == 25 then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
