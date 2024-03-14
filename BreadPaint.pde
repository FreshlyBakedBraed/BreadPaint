
import com.krab.lazy.*;
LazyGui gui;


ArrayList<CurrentDrawing> drawnpixels; //<>//
ArrayList<Integer> layer_no;
ArrayList<String> layer_name;
int total_created_layers = 1;
int current_layer = 0;
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

layer_name = new ArrayList<String>();
layer_no = new ArrayList<Integer>();
drawnpixels = new ArrayList<CurrentDrawing>();

layer_name.add("Layer 0");
layer_no.add(0);


gui.button("Clear Drawing");
gui.button("Clear Current Layer");
gui.button("Add Layer");
gui.radio("Layer ",layer_name);
gui.radio("Brushes", new String[] {"Square", "Circle"});
gui.sliderInt("Brush Size");
gui.colorPicker("Color Picker");
}







void draw(){
background(gui.colorPicker("Background Color").hex);
if(gui.button("Add Layer")){
    AddLayer();
    }  
TimedStatCheck();
DrawCurrentLines();
if(gui.button("Clear Drawing")){
    drawnpixels.clear();  
    }
if(gui.button("Clear Current Layer")){
    drawnpixels.removeIf(n ->n.timedLayer == current_layer);
    }
}















void AddLayer(){
total_created_layers++;
  for(int c= 0;c<total_created_layers;c++){
    if(layer_no.contains(c)){
      println("This Layer Already Exists");
    }else {
        layer_name.add("Layer "+c);
        layer_no.add(c);
        println("Adding Layer " +c);
    }
  }
gui.radioSetOptions("Layer ",layer_name);

}


void TimedStatCheck(){

String selection = gui.radio("Layer ", layer_name);
for(Integer every : layer_no){
   String tempstr = Integer.toString(every);
   println("tempstr is " + tempstr);
   println("selection is "+ selection);
  if(selection.equals("Layer " + tempstr)){
      current_layer = every;
      println("Current Layer " + current_layer);
  }
}
String mode = gui.radio("Brushes", new String[]{"Square", "Circle"});
if (mode.equals("Square")) {
    currentState = State.square;
} else{
 currentState = State.circle;
}


}


void DrawCurrentLines(){
noStroke();
for(CurrentDrawing isPixel : drawnpixels){
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
     drawnpixels.add(new CurrentDrawing(mouseX,mouseY,gui.sliderInt("Brush Size"),gui.colorPicker("Color Picker").hex,currentState,current_layer));
 }
}
void keyPressed(){
if (key == 'S'|| key == 's'){
  save("Latest_drawing.png");
}
}
