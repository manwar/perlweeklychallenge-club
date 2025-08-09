-- insert in res while res<=x
function Dup2(x)
    local len = #x
    local res = {}
    for l,v in ipairs(x) do
        
        if v == 0 then
            table.insert(res,0)
            if #res >= len then break end
            table.insert(res,0)
        else 
            table.insert(res,v)
        end
        if #res >= len then break end
    end

    for k,m in ipairs(res) do
        io.write (m," ")
    end
    io.write ("\n")
end

Dup2({ 1; 0; 2; 3; 0; 4; 5; 0})
Dup2({ 1;2;3})
Dup2({ 1;2;3;0})
Dup2({ 0;0;1;2})
Dup2({ 1;2;0;3;4})
