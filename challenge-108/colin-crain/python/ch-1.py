foo = 42
loc_foo = hex(id(foo))

print( "the variable 'foo' is located at:", loc_foo )

bar = 42
loc_bar = hex(id(bar))

print( "the variable 'bar' is located at:", loc_bar )
print( "bar equals foo                  :", bar == foo )
print( "bar is the same object as foo   :", bar is foo)

if loc_foo == loc_bar:
    print( "the value", foo, "is interned")
else:
    print( "the value", foo, "is not interned")
