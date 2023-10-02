# Task 2: Senior Citizens
# Submitted by: Mohammad S Anwar
# 
# You are given a list of passenger details in the form “9999999999A1122”, where 9 denotes the phone number, A the sex, 1 the age and 2 the seat number.
# Write a script to return the count of all senior citizens (age >= 60).
#
# Example 1
# Input: @list = ("7868190130M7522","5303914400F9211","9273338290F4010")
# Ouput: 2
# 
# The age of the passengers in the given list are 75, 92 and 40.
# So we have only 2 senior citizens.
# 
# Example 2
# Input: @list = ("1313579440F2036","2921522980M5644")
# Ouput: 0

def count_seniors(passengers):
    return len([x for x in passengers if int(x[11:13]) >= 60])

if __name__ == "__main__":
    lists = [
        ["7868190130M7522","5303914400F9211","9273338290F4010"],
        ["1313579440F2036","2921522980M5644"]
    ]
    for passengers in lists:
        print(', '.join(passengers) + ' -> ' + str(count_seniors(passengers)))

