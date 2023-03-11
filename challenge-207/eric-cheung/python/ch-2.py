
## https://gist.github.com/restrepo/c5f8f9fd5504a3f93ae34dd10a5dd6b0

def hIndex(arrCitation):

    ### https://github.com/kamyu104/LeetCode/blob/master/Python/h-index.py
    ### :type arrCitation: List[int]
    ### :rtype: int

    ### Given an array of citations (each citation is a non-negative integer)
    ### of a researcher, write a function to compute the researcher's h-index.
    ### 
    ### According to the definition of h-index on Wikipedia: 
    ### "A scientist has index h if h of his/her N papers have
    ### at least h citations each, and the other N − h papers have
    ### no more than h citations each."
    ### 
    ### For example, given arrCitation = [3, 0, 6, 1, 5], 
    ### which means the researcher has 5 papers in total
    ### and each of them had received 3, 0, 6, 1, 5 citations respectively. 
    ### Since the researcher has 3 papers with at least 3 citations each and 
    ### the remaining two with no more than 3 citations each, his h-index is 3.
    ### 
    ### Note: If there are several possible values for h, the maximum one is taken as the h-index.

    return sum(nLoop >= nIndx + 1 for nIndx, nLoop in enumerate(sorted(list(arrCitation), reverse = True)))


## arrInputCitation = [10, 8, 5, 4, 3]  ## Example 1
arrInputCitation = [25, 8, 5, 3, 3]  ## Example 2

print (hIndex(arrInputCitation))
