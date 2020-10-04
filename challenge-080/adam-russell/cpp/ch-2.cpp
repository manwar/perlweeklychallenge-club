#include <iostream>
/*
* You are given rankings of @N candidates.
* Write a script to find out the total candies needed for all candidates. 
* You are asked to follow the rules below:
*     a) You must given at least one candy to each candidate.
*     b) Candidate with higher ranking get more candies than their immediate
*        neighbors on either side.
*/
int count_candies(int candidates[]){
    int candies = 4;
    for(int i = 0; i < 3; i++){
        if((i - 1) >= 0){
            if(candidates[i] > candidates[i - 1]){
                candies++;
            }
        }
        if((i + 1) < 4){
            if(candidates[i] > candidates[i + 1]){
                candies++;
            }
        }
    }
    return candies;
}
int main(int argc, char** argv){
    int N[4] = {1, 4, 3, 2};
    int i = count_candies(N);
    std::cout << "the number of candies is " << i << std::endl;
}