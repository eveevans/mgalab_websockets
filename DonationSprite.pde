class DonationSprite {
  
  Integer id;
  String name;
  Float amount;
  Boolean anonymous;
  
  //String tmp = {"donor":"VIctor","amount":0.1,"anonymous":false}';
  
  DonationSprite(Integer pid, String pname, Float pamount, Boolean panonymous){
    id = pid;
    name = pname;
    amount = pamount;
    anonymous = panonymous;
  }
  
  Float donationAmount(){
    return amount;
  }
  
  String donationName(){
    return name;
  }
  
  void display(){
    line(0,0,100,100);
  }
  
}