
    
        #include<iostream>
        #include<vector>
        #include<algorithm>
        /*
        * Write a script to generate first 5 Pandigital Numbers in base 10.
        */
    
    
        class Pandigital{
            public: 
                std::vector<int> first_n_pandigitals(int);
                std::vector<int> first_5_pandigitals();
        };
    
    
        std::vector<int> Pandigital::first_n_pandigitals(int n){
            std::vector<int> pandigitals;
            int x = 1000000000;
            do{
                
                    int test = x;
                    std::vector<int> test_vector;
                    do{
                        test_vector.push_back(test % 10);
                        test = test / 10;  
                    }while(test > 0);
                    if(std::count(test_vector.begin(), test_vector.end(), 0) && 
                       std::count(test_vector.begin(), test_vector.end(), 1) && 
                       std::count(test_vector.begin(), test_vector.end(), 2) && 
                       std::count(test_vector.begin(), test_vector.end(), 3) && 
                       std::count(test_vector.begin(), test_vector.end(), 4) && 
                       std::count(test_vector.begin(), test_vector.end(), 5) && 
                       std::count(test_vector.begin(), test_vector.end(), 6) && 
                       std::count(test_vector.begin(), test_vector.end(), 7) && 
                       std::count(test_vector.begin(), test_vector.end(), 8) && 
                       std::count(test_vector.begin(), test_vector.end(), 9))
                           pandigitals.push_back(x);
                
                x++; 
            }while(pandigitals.size() < n);
            return pandigitals;
        }
    
    
        std::vector<int> Pandigital::first_5_pandigitals(){
            return this->first_n_pandigitals(5);
        }
    
    
        int main(int argc, char** argv){
            Pandigital p;
            std::vector<int> pandigitals = p.first_5_pandigitals();
            for(int i = 0; i < pandigitals.size(); i++){
                std::cout << pandigitals[i] << std::endl;
            }
        }
    
