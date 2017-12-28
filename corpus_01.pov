#include "colors.inc"
#include "glass.inc"
#include "textures.inc"
#include "shapes.inc"
#include "shapes3.inc"

#include "Round_Box_Y.inc"
#include "mdrink.pov"

#include "metal.pov"

#include "basic.pov"
#include "display.pov"
#include "fan.pov"

#include "woods.inc"

#include "register.pov"

#declare m_wall_dist=0.01;


#declare paperA4 = object {
  box { <0,0,0,> <0.21, 0.00008, 0.297>  } 
  texture { 
        pigment{ color rgb<1,1,1>
        }
        finish { ambient 0.4 diffuse 0.6 }
  }
}


#declare paper8 = object {
  box { <0,0,0,> <0.075, 0.00008, 0.105>  } 
  texture { 
        pigment{ color rgb<1,1,1>
        }
        finish { ambient 0.4 diffuse 0.6 }
  }
}



#macro Foot(rad, height)
    cylinder {
        <0, 0, 0>,     // Center of one end
        <0, height, 0>,     // Center of other end
        rad            // Radius
        texture { t_metal_glossy_warp }
    }
#end

#macro DeskInside(height, wdth, depth, thkTop, edgeTop, thkSide, heightDeskFront, thkDesk, thk, footHeight, footRad)
    object{
        difference{
            object{
                Element(wdth-2*thkSide, depth-thk, thkDesk, 0.0005)
            }
            box{
                <wdth-2*thkSide-0.07,-0.01,0.04>,
                <wdth-2*thkSide-0.07-0.1,thkDesk+0.01,0.04+0.04>
            }
            cylinder{
                <wdth-2*thkSide-0.07,-0.01,0.04+0.02>,
                <wdth-2*thkSide-0.07,thkDesk+0.01,0.04+0.02>,
                0.02
            }
            cylinder{
                <wdth-2*thkSide-0.07-0.1,-0.01,0.04+0.02>,
                <wdth-2*thkSide-0.07-0.1,thkDesk+0.01,0.04+0.02>,
                0.02
            }
        }
        TextureBoard()
        translate <thkSide,0,0>
    }
#end

#macro Corpus01(height, wdth, depth, thkTop, edgeTop, thkSide, heightDesk, heightDeskFront, thkDesk, thk, footHeight, footRad)
    union{
        // Deckel und Fussplatte
        object{Board(wdth, depth, thkTop, edgeTop) translate y*footHeight}
        object{Board(wdth, depth, thkTop, edgeTop) translate y*(height-thkTop)}
        // 4 Fuesse
        object{Foot(footRad, footHeight) translate <footRad+0.02, 0, footRad+0.02>}
        object{Foot(footRad, footHeight) translate <footRad+0.02, 0, depth-footRad-0.02>}
        object{Foot(footRad, footHeight) translate <wdth-footRad-0.02, 0, footRad+0.02>}
        object{Foot(footRad, footHeight) translate <wdth-footRad-0.02, 0, depth-footRad-0.02>}
        // 2 seitenwaende
        #local Sides=object{Board(height-thkTop*2-footHeight, depth-thk-0.0001, thkSide, edgeTop)}
        object{Sides rotate z*90 translate <thkSide, (footHeight+thkTop), 0>}
        object{Sides rotate z*90 translate <wdth, (footHeight+thkTop), 0>}
        // Rueckwand
        object{
            difference{
                object{
                    Element(wdth-2*thkSide, height-thkTop*2-footHeight, 0.003, 0.0004)            
                    rotate x*90 translate <thkSide, height-thkTop, 0.003>
                }
                box{<0.04+thkSide,0.54,0>,<0.04+thkSide+0.1, 0.54+0.1, 0.008>}
                box{<wdth-thkSide-0.2,0.54,0>,<wdth-thkSide-0.2+0.12, 0.54+0.12, 0.008>}
            }
            rotate -x*90
            TextureBoard()
            rotate x*90
        }
        // Ventillator
        object{
            AnimateFan(120, 20, 1, clock)
            rotate x*90
            translate <wdth-thkSide-0.2+0.06, 0.54+0.06,0.003>
        }
        // oberhalb schreibschublade
        object{DeskInside(height, wdth, depth, thkTop, edgeTop, thkSide, heightDeskFront, thkDesk, thk, footHeight, footRad) translate (heightDesk+0.01)*y}
    }
#end
