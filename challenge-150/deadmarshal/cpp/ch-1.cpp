#include<iostream>
#include<vector>
#include<string>
#include<cstdlib>

int main(int argc, char *argv[])
{
  if(argc < 2)
  {
    std::cerr << "Provide 2 args!";
    exit(1);
  }
  
  std::vector<std::string> v{};
  v.push_back(argv[1]);
  v.push_back(argv[2]);

  do{
    v.push_back(v.end()[-2] + v.end()[-1]);
  }while(v[v.size()-1].size() <= 51);
  
  std::cout << v[v.size()-1][50] << "\n";
  
  return 0;
}
