
import com.krab.lazy.*;
LazyGui gui;


ArrayList<CurrentDrawing> drawnpixels; //<>//
ArrayList<Integer> layer_no;
ArrayList<String> layer_name;
int total_created_layers = 1;
int current_layer = 0;
public enum State{
 circle,square,erase
}
State currentState;



void setup(){
  
size(1000,1000,P2D); // lazy gui doesnt work unless i specify the P2D bc idk 
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
gui.radio("Brushes", new String[] {"Eraser","Square", "Circle"});
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







void AddLayer(){ // layer logic. it kinda sux that i have to hard code this with strings thats why im trying to integrate layer information the the class of CurrentDrawing 
                 //so I can make a more compact class of everything that has to do with the data of the lines including frame information for the animating tool
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
   //println("tempstr is " + tempstr);
   //println("selection is "+ selection);
  if(selection.equals("Layer " + tempstr)){
      current_layer = every;
      //println("Current Layer " + current_layer);
  }
}
String mode = gui.radio("Brushes", new String[]{"Eraser","Square", "Circle"});
if (mode.equals("Square")) { // selection of brushes. might add the ability to make custom brushes soon.
    currentState = State.square;
} else if(mode.equals("Circle")){
 currentState = State.circle;
} else if(mode.equals("Eraser")){
  currentState = State.erase;
}


}


void DrawCurrentLines(){ // name is pretty self explnatory. runs through all recorded objects within currently drawn pixels arryay list and simply draws them. 
noStroke();
for(CurrentDrawing isPixel : drawnpixels){
  fill(isPixel.timedColor);
  if(isPixel.timedState == State.square){
  rect(isPixel.x_loc,isPixel.y_loc,isPixel.size,isPixel.size);
  } else if(isPixel.timedState == State.circle){
    circle(isPixel.x_loc,isPixel.y_loc,isPixel.size);
  } else if(isPixel.timedState == State.erase){
  pushStyle(); // used push pop style for eraser instead of manually setting the brush color again
  fill(gui.colorPicker("Background Color").hex);
  circle(isPixel.x_loc,isPixel.y_loc,isPixel.size);
  popStyle();
  }
  
}
}





void mouseDragged(){  
  if(gui.isMouseOutsideGui()){
     drawnpixels.add(new CurrentDrawing(mouseX,mouseY,gui.sliderInt("Brush Size"),gui.colorPicker("Color Picker").hex,currentState,current_layer)); // actual drawing which is just adding information to arraylist of all drawn pixels
 }                                                                                                                                                  // i dont know how efficent this is memory wise we just ball
}
void keyPressed(){
int d = day();     // time logic
int m = month();  
int y = year();
int s = second(); 
int mi = minute();  
int h = hour(); 

if (key == 'S'|| key == 's'){ //saving the picutre
  save(d+"."+m+"."+y+"_"+h+"."+mi+"."+s+".png");
}
}
