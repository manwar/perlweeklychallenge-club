function f(p)
    return p / 2 + 1
end
function g(p)
    return p * 2
end
function compose(h1, h2)
    return h1 ∘ h2;
end
h = compose(f, g)
for i in 1:5
    println(h(i), "  ", f(g(i)))
end
