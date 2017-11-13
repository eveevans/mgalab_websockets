import org.apache.http.client.methods.HttpRequestBase;
import org.apache.http.client.HttpClient;

import com.pusher.client.Pusher;
import com.pusher.client.channel.Channel;
import com.pusher.client.channel.SubscriptionEventListener;

import http.requests.*;

void setup(){  
  size(200,200);
  PusherOptions options = new PusherOptions();
  options.setCluster("us2");
  Pusher pusher = new Pusher("", options);
  Channel channel = pusher.subscribe("donations");
  
  //String tmp = {"donor":"VIctor","amount":0.1,"anonymous":false}';
  
  channel.bind("new_donation", new SubscriptionEventListener() {
    @Override
    public void onEvent(String channelName, String eventName, final String data) {
      System.out.println(data);    
      JSONObject donationObj = parseJSONObject(data);      
      println( donationObj.getString("donor") );
      println( donationObj.getFloat("amount") );
      println( donationObj.getBoolean("anonymous") );           
    }
  });
  
  pusher.connect();
}

void draw(){  
}