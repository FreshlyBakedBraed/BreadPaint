class Layers{
String name;
int number;




Layers(String n,int x){
name = n;
number = x;
}

String GetName(){
  return name;
}

int GetNumber(){
  return number;
}

boolean CheckNumber(int p){
if(p==number){
return true;
}else{
return false;
}
}

}
