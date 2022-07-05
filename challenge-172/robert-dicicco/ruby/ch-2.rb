#!ruby.exe

# AUTHOR: Robert DiCicco
# DATE: 2022-07-05
# Challenge 172 Five Numbers ( Ruby )

# Got both of these routines off of StackOverflow

# IDNRTW        ( I Do Not Reinvent The Wheel )

def median(array)                            #Define your method accepting an array as an argument.

      array = array.sort                     #sort the array from least to greatest

      if array.length.odd?                   #is the length of the array odd?

        array[(array.length - 1) / 2]        #find value at this index

      else array.length.even?                #is the length of the array even?

       (array[array.length/2] + array[array.length/2 - 1])/2.to_f

                                             #average the values found at these two indexes and convert to float

      end

end

def percentile(values, percentile)

      values_sorted = values.sort

      k = (percentile*(values_sorted.length-1)+1).floor - 1

      f = (percentile*(values_sorted.length-1)+1).modulo(1)

      return values_sorted[k] + (f * (values_sorted[k+1] - values_sorted[k]))

end

arr = [10,12,14,16,18,24]

med = median(arr)

print("#{arr}\n")

print("Min = #{arr.min}  Q1 = #{percentile(arr,0.25)} Median = #{med}  Q3 = #{percentile(arr,0.75)}  Max = #{arr.max}\n")
