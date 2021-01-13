# Python3
# Perl Weekly Challenge #075 Task 1 Coins Sum, Python script
# task statement: 
# You are given a set of coins @C, assuming you have 
# infinite amount of each coin in the set.
# Write a script to find how many ways you make 
# sum $S using the coins from the set @C.

def coins_sum(uinput):
    userinput = uinput
    total = userinput.pop(0)
    coins = userinput
    dp_range = []
    arr_for_dp = [ [] ]

    dp_range = list((range(1,total+1)))

#initialize the array for dynamic programming
    j = 0
    for i in dp_range:
        if i == coins[j]:
            arr_for_dp.append([ [coins[j]] ])
            if j < len(coins)-1:
                j = j+1 
        else:
            arr_for_dp.append([])

    for i in dp_range:
        for k in range(len(coins)):
            if (i-coins[k] > 0):
                for p in range(len(arr_for_dp[i-coins[k]])):
                    partition = arr_for_dp[i-coins[k]][p]
                    partition_p = partition.copy()
                    partition_p.append(coins[k])
                    partition_p = sorted(partition_p)
                    if not(partition_p in arr_for_dp[i]):
                        arr_for_dp[i].append(partition_p.copy())

    #return answer
    return arr_for_dp[total]


if __name__ == "__main__":
    urinput = [];
    target = int(input("Enter the sum: \n"))
    set_of_coins = [int(x) for x in input("Enter the value of coins with spaces seperated:\n").split()]
    urinput = [target] + set_of_coins;

    print(urinput)
    ans = coins_sum( urinput )
    print("===================")
    for item in ans:
        print(item)
    print("answer: ", len(ans))
