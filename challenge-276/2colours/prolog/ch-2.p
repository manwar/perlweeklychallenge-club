aggregate_bag(Value-Amount, [], [Value-Amount]).
aggregate_bag(Value-Amount, [Value-Old_Amount|Rest], [Value-New_Amount|Rest]) :- !, New_Amount is Old_Amount + Amount.
aggregate_bag(Value-Amount, [Other_Value-Amount2|Rest], [Value-Amount, Other_Value-Amount2|Rest]).

% task2(Ints, Most_Frequent_Count) :- clumped(Ints, Ints_RLE), msort(Ints_RLE, Sorted_RLE), foldl(aggregate_bag, Sorted_RLE, [], Aggregated_RLE), pairs_values(Aggregated_RLE, Counts), max_list(Counts, Max_Count), include(=(Max_Count), Counts, All_Maxes), sum_list(All_Maxes, Most_Frequent_Count).

task2(Ints, Most_Frequent_Count) :- msort(Ints, Sorted_Ints), clumped(Sorted_Ints, Ints_Counted), pairs_values(Ints_Counted, Counts), max_list(Counts, Max_Count), include(=(Max_Count), Counts, All_Maxes), sum_list(All_Maxes, Most_Frequent_Count).

