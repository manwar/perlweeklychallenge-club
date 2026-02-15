
function dummy(x, y) 
  local first = string.byte(string.sub(x,1,1))
  local sec = string.byte(string.sub(y,1,1))

  if first < 91 then
     first = first + 32
  end
  if sec < 91 then
     sec = sec + 32
  end
  return first < sec
end


function sortfirstchar(x)
    local test = {}
    for w in x:gmatch("%S+") do 
        table.insert(test,w) 
    end

    table.sort(test,dummy)

    print(table.concat(test," "))

    
end 

sortfirstchar("The quick brown fox")
sortfirstchar( "Hello    World!   How   are you?")
sortfirstchar("Hello")
sortfirstchar( "Hello, World! How are you?")
sortfirstchar("I have 2 apples and 3 bananas!")