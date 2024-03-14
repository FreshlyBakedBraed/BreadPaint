PGraphics pg;
import com.krab.lazy.*;
LazyGui gui;
ArrayList<CurrentDrawing> drawnpixels; //<>//
ArrayList<Layers> all_layers;
ArrayList<String> layer_name;
int total_created_layers = 1;
int current_layer;
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


drawnpixels = new ArrayList<CurrentDrawing>();
all_layers = new ArrayList<Layers>();
layer_name = new ArrayList<String>();

layer_name.add("Layer 0");
all_layers.add(new Layers("Layer 0",0));
gui.button("Clear Drawing");
gui.button("Add Layer");
gui.radio("Layers", layer_name);
gui.radio("Brushes", new String[] {"Square", "Circle"});
gui.sliderInt("Brush Size");
gui.colorPicker("Color Picker");

}


void draw(){
background(#FFFFFF);
if(gui.button("Add Layer")){
  total_created_layers++;
for(Layers current : all_layers) {
  for(int i = 0;i < total_created_layers;i++){
     if(current.CheckNumber(i)){
       println("layer already exists");
       }    
     else{
       all_layers.add(new Layers("Layer "+ i ,i));
       println("Layer added " + i); //Debug Code
       }
     }
}
gui.radioSetOptions("Layers", layer_name);
}
//String SelectedLayer = gui.radio("Layers", layer_name);
/*for(String  all : layer_name){
if(SelectedLayer.equals("")){

}
}
*/
String mode = gui.radio("Brushes", new String[]{"square", "circle"});
if (mode.equals("square")) {
    currentState = State.square;
} else{
 currentState = State.circle;
}
DrawCurrentLines();
if(gui.button("Clear Drawing")){
   drawnpixels.clear();  
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
     drawnpixels.add(new CurrentDrawing(mouseX,mouseY,gui.sliderInt("Brush Size"),gui.colorPicker("Color Picker").hex,currentState,1));
 }
}
void keyPressed(){
if (key == 'S'|| key == 's'){
  save("Latest_drawing.png");
}
}
