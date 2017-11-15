class DonationCollection {
  
  ArrayList<DonationSprite> donations; 
  
  DonationCollection(){
    donations = new ArrayList<DonationSprite>();
  }
  
  void update(){    
    for(DonationSprite d : donations){
      line(0,0,d.donationAmount(), d.donationAmount() );
      
        //String s = "Cualquier cosa";
        fill(50);
        textSize(72);
        text(d.donationName(),d.donationAmount(),d.donationAmount(),800,800);
        text(str(d.donationAmount()),d.donationAmount(),d.donationAmount()+30, 800, 800);
      
    }
  }
  
  void add(String name, Float amount, Boolean anonymous){
    donations.add( new DonationSprite(name, amount, anonymous) );
  }  
  
}