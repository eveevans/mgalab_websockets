class DonationCollection {
  
  ArrayList<DonationSprite> donations; 
  
  DonationCollection(){
    donations = new ArrayList<DonationSprite>();
  }
  
  void update(){    
    for(DonationSprite d : donations){
      line(0,0,d.donationAmount(), d.donationAmount() );
    }
  }
  
  void add(String name, Float amount, Boolean anonymous){
    donations.add( new DonationSprite(name, amount, anonymous) );
  }  
  
}