#! /usr/bin/ruby

def pentagon(n)
  return (n*(3*n-1)/2).to_i
end

def pentpair()
  fpent=[0]
  rpent=Hash.new
  mx=0
  a=1
  while 1 do
    while mx < a do
      mx += 1
      fpent.push(pentagon(mx))
      rpent[fpent[mx]]=mx
    end
    1.upto(a-1) do |b|
      d=fpent[a]-fpent[b]
      if rpent.has_key?(d) then
        s=fpent[a]+fpent[b]
        while s > fpent[mx] do
          mx += 1
          fpent.push(pentagon(mx))
          rpent[fpent[mx]]=mx
        end
        if rpent.has_key?(s) then
          print("P(#{a}) + P(#{b}) = #{fpent[a]} + #{fpent[b]} = #{s} = P(#{rpent[s]})\n")
          print("P(#{a}) - P(#{b}) = #{fpent[a]} - #{fpent[b]} = #{d} = P(#{rpent[d]})\n")
          exit(0)
        end
      end
    end
    a += 1
  end
end

pentpair()
