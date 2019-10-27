#include <string> 
#include <iostream>

#define QUOTE(name) #name
#define MAKE_NAME(name) QUOTE(name) 
#define VARIABLE_NAME MAKE_NAME(VARIABLE)   

int main(){
    using namespace std; 
    string name = VARIABLE_NAME; 
    int VARIABLE = VALUE;
    cout << "The value of " << name << " is " << VARIABLE << "." << endl;
} 
