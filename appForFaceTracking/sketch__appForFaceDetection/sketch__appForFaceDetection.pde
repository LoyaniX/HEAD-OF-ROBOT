import gab.opencv.*;                                  
import processing.video.*;                            
import processing.serial.*;                           
Serial myPort;                                        
import java.awt.*;                                    
Capture video;                                        
OpenCV opencv;                                       
int x, y, w;    

void settings() {
  
  size(640, 480);
}

void setup() {
  
  textSize(32);                                       
  fill(color(#0000FF));                               
  surface.setAlwaysOnTop(true);                       
  surface.setResizable(true);    
  String[] cameras = Capture.list();
  println("Available cameras:"); //выводит список всех камер доступных в системе, на функционал не влияет
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
  video = new Capture(this, 640/2, 480/2);           
  opencv = new OpenCV(this, 640/2, 480/2);            
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);     
  video.start();
  stroke(0, 255, 0);                                  
  strokeWeight(3);                                    
}
void draw() {
  
  textSize(32);                                       
  background(color(#EDFF00));                         
  opencv.loadImage(video);                            
  Rectangle[] faces = opencv.detect();                
  scale(2);                                           
  image(video, 0, 0 );                                
  noFill();                                           
  for (int i = 0; i < faces.length; i++) {            
    rect(x=faces[i].x, y=faces[i].y, w=faces[i].width, faces[i].height); 
    x = constrain(x, 1, 255);                         
    y = constrain(y, 1, 255);                                                         
    fill(color(#0000FF));                             
    text(" x:↔ " + x, 0, 30);                         
    fill(color(#FF082D));                             
    text("y: ↨ " + y, 0, 60);                       
    fill(color(#63FC4C));                             
  }
}

void captureEvent(Capture c) {  
  
  c.read();
}
