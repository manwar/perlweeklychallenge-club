#! /usr/bin/lua

function pentagon(n)
   return math.floor(n*(3*n-1)/2)
end

function pentpair()
   fpent={}
   rpent={}
   mx=0
   a=1
   while 1 do
      while mx < a do
         mx = mx + 1
         table.insert(fpent,pentagon(mx))
         rpent[fpent[mx]]=mx
      end
      for b = 1,a do
         d=fpent[a]-fpent[b]
         if d < fpent[b] then
            break
         end
         if rpent[d] ~= nil then
            s=fpent[a]+fpent[b]
            while s > fpent[mx] do
               mx = mx + 1
               table.insert(fpent,pentagon(mx))
               rpent[fpent[mx]]=mx
            end
            if rpent[s] ~= nil then
               print(string.format("P(%d) + P(%d) = %d + %d = %d = P(%d)",a,b,fpent[a],fpent[b],s,rpent[s]))
               print(string.format("P(%d) - P(%d) = %d - %d = %d = P(%d)",a,b,fpent[a],fpent[b],d,rpent[d]))
               os.exit(0)
            end
         end
      end
      a = a + 1
   end
end

pentpair()
