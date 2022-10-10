#!julia.exe

# AUTHOR: Robert DiCicco
# DATE: 2022-09-26
# Challenge 184 Sequence Number ( Julia )

using Printf

cnt = 0

arr = ["ab1234", "cd5678", "ef1342"]

#arr = [ "pq1122", "rs3334" ]

print("Input: ( ")

for i in 1:length(arr)

  print(arr[i]," ")

end

println(" )")

print("Output: ( ")

for i in 1:length(arr)

  pt1 = SubString(arr[i],1,2)

  pt2 = SubString(arr[i],3,6)

  text1 = @sprintf("%.2d", cnt );

  print(text1,pt2," ")

  global cnt += 1

end

println(" )")
