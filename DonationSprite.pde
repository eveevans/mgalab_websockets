class DonationSprite {
  
  Integer id;
  String name;
  Float amount;
  Boolean anonymous;
  
  //String tmp = {"id": 1, "donor":"VIctor","amount":0.1,"anonymous":false}';
  
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
  
  Integer donationId(){
    return id;
  }
  
  void display(){
    line(0,0,100,100);
  }
  
}