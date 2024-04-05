class CurrentDrawing{
int x_loc;
int y_loc;
int size;
int timedColor;
State timedState;
int timedLayer;
String layer_name;
int layer_no;
int frame_no;


void LayerGetter(){
}

void LayerSetter(){
}


void FrameGetter(){
}

void FrameSetter(){
}


CurrentDrawing(int x,int y,int s,int c, State state,int l){
x_loc = x;
y_loc = y;
size = s;
timedColor = c;
timedState = state;
timedLayer = l;
}
}
