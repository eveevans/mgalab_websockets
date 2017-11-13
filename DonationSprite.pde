class DonationSprite {
  
  String name;
  Float amount;
  Boolean anonymous;
  
  //String tmp = {"donor":"VIctor","amount":0.1,"anonymous":false}';
  
  DonationSprite(String pname, Float pamount, Boolean panonymous){
    name = pname;
    amount = pamount;
    anonymous = panonymous;
  }
  
  Float donationAmount(){
    return amount;
  }
  
  void display(){
    line(0,0,100,100);
  }
  
}