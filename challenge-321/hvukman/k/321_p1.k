"part 1"
// min and max function
min: {&/x}
max: {|/x}
inp: 1 2 4 3 5 6
// clumsily put distance in global dist then reset it
dist::()
// do while until inp is length zero, add average into dist at every step
dummy:  {(#x)>1}{ dist::dist, (max x+min x)%2; ;({(~(max x)=)#x} {(~(min x)=)#x}x)}\inp
// deduplicate and print it
#?dist
inp: 0 2 4 8 3 5
dist::()
dummy:  {(#x)>1}{ dist::dist, (max x+min x)%2; ;({(~(max x)=)#x} {(~(min x)=)#x}x)}\inp
#?dist
inp: 7 3 1 0 5 9
dist::()
dummy:  {(#x)>1}{ dist::dist, (max x+min x)%2; ;({(~(max x)=)#x} {(~(min x)=)#x}x)}\inp
#?dist

