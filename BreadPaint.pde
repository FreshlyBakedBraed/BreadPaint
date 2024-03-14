PGraphics pg;
import com.krab.lazy.*;
LazyGui gui;
ArrayList<CurrentDrawing> pixels; //<>//
public enum State{
 circle,square
}
State currentState = State.square;




void setup(){
size(1000,1000,P2D);
surface.setResizable(false);
frameRate(60);
background(#FFFFFF);
gui = new LazyGui(this);
rectMode(CENTER);
pixels = new ArrayList<CurrentDrawing>();
}


void draw(){
background(#FFFFFF);
String mode = gui.radio("Brushes", new String[]{"square", "circle"});
if (mode.equals("square")) {
    currentState = State.square;
} else{
 currentState = State.circle;
}
DrawCurrentLines();
if(gui.button("Clear Drawing")){
   pixels.clear();  
}
}


void DrawCurrentLines(){
noStroke();
for(CurrentDrawing isPixel : pixels){
  fill(isPixel.timedColor);
  if(isPixel.timedState == State.square){
  rect(isPixel.x_loc,isPixel.y_loc,isPixel.size,isPixel.size);
  } else if(isPixel.timedState == State.circle){
    circle(isPixel.x_loc,isPixel.y_loc,isPixel.size);
  }
}

}

void mouseDragged(){  
  if(gui.isMouseOutsideGui()){
     pixels.add(new CurrentDrawing(mouseX,mouseY,gui.sliderInt("Brush Size"),gui.colorPicker("Color Picker").hex,currentState));
 }
}
void keyPressed(){
if (key == 'S'|| key == 's'){
  save("Latest_drawing.png");
}
}
