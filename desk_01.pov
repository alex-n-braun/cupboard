#include "colors.inc"
#include "glass.inc"
#include "textures.inc"
#include "shapes.inc"
#include "shapes3.inc"

#include "Round_Box_Y.inc"
#include "mdrink.pov"

#include "metal.pov"

#include "display.pov"
#include "fan.pov"
#include "corpus_01.pov"

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


#macro Handle(height, wdth, ornt, rot)
     union{
        object{Element(wdth, 0.022, 0.002, 0.00099)
            translate y*(height-0.002)
        }
        object{Element(wdth, 0.022, 0.002, 0.00099)
        }
        object{Element(0.02, 0.022, height, 0.00099)
        }
        object{Element(0.02, 0.022, height, 0.00099)
            translate x*(wdth - 0.02)
        }
        object{Element(wdth, 0.003, height, 0.00099)
            translate <0,0,0>
        }        
        // Griff
        #local H_Spacng = 0.0005;
        union {
            object{Element(0.008, 0.008, height-0.002, 0.00003)
                translate <wdth-(0.02+H_Spacng+0.03-0.5*0.008), 0.001, 0.022-0.008-0.0015>
            }
            object{Element(wdth-2*0.02-2*H_Spacng, 0.003, height-2*0.002-2*H_Spacng, 0.0014)
                translate <0.02+H_Spacng,0.002+H_Spacng,0.022-0.003>
            }
            translate <-0.004-(wdth-(0.02+H_Spacng+0.03-0.5*0.008)), 0, -0.004-(0.022-0.008-0.0015)>
            rotate y*rot
            translate <+0.004+(wdth-(0.02+H_Spacng+0.03-0.5*0.008)), 0, +0.004+(0.022-0.008-0.0015)>
        }
        translate -0.002*z
        texture { t_metal_glossy_jvp }
        translate <-0.5*wdth,-0.5*height, 0>
        rotate z*180*ornt
        translate <0.5*wdth,0.5*height, 0>
     }
#end


#macro Pencil(len)
  #local RadPencil = 0.4;
  union {
     cylinder { <0,0,0> <0,100*len-1,0>
        RadPencil
        texture { pigment { DMFDarkOak }}
        interior{ I_Glass}
     }
     cylinder { <0,100*len-1,0> <0,100*len,0>
        RadPencil
        texture { Gold_Metal }
     }
     cone { <0,0,0>RadPencil <0,-0.8,0>
        0.1
        texture { pigment { White_Wood } }
        interior{ I_Glass}
     }
     cone { <0,-0.8,0> 0.1 <0,-1, 0> 0
        texture { pigment { Black } }
        interior{ I_Glass}
     }
     rotate -x*90
     translate y*RadPencil
     scale 0.01
  }
#end

#macro DeskTop(height, wdth, depth, thkTop, edgeTop, thkSide, heightDeskFront, thkDesk, thk, footHeight, footRad, handle)
    union{
        #local inset_wdth = 0.11;
        #local inset_depth = 0.33;
        #local inset_thk = 0.015;
        #local inset_rad_out = 0.01;
        #local inset_pos = <0.025, thkDesk-inset_thk, depth-inset_depth-thk-0.015>;
        difference {
            // Platte
            object{Element(wdth-2*thkSide-2*0.01, depth-thk, thkDesk, 0.0005)
                translate x*(thkSide+0.01)-z*depth}
            // Ausschnitt für Griff
            object{Element(0.12, 0.035, 3*thk, 0.00099)
                rotate x*90 translate <wdth*0.5-0.06,thkDesk-0.5*heightDeskFront+0.5*0.035,-1.3*thk>}
            // Ausschnitt für Glasplatte
            object{
                Element(0.7, depth-thk, 0.01, 0.0005)
                translate <wdth-0.7-thkSide-0.01-0.1, 0.0005+thkDesk-0.01, -(depth-0.5*thk)>
            }
            // Ausschnitt für Aufbewahrung
            object{
                Element(inset_wdth,inset_depth,inset_thk*3,inset_rad_out)
                translate <(thkSide+0.01),0., -depth>+inset_pos
            }
            TextureBoard()
        }
        difference {
            // Front
            object{Element(wdth, heightDeskFront, thk, edgeTop) 
                rotate x*90 translate <0,thkDesk,-thk>
            }
            // Ausschnitte, siehe oben
            object{Element(0.12, 0.035, 3*thk, 0.00099)
                rotate x*90 translate <wdth*0.5-0.06,thkDesk-0.5*heightDeskFront+0.5*0.035,-1.3*thk>
            }
            object{
                Element(0.7, depth-thk, 0.01, 0.0005)
                translate <wdth-0.7-thkSide-0.01-0.1, 0.0005+thkDesk-0.01, -(depth-0.5*thk)>
            }
//             translate <0,-thkDesk,0> 
            rotate -x*90 
            TextureBoard()
            rotate x*90 
//             translate <0,thkDesk,0> 
        }
        
        // Griff
        object{Handle(0.035, 0.12, 0, handle) translate <wdth*0.5-0.06,thkDesk-0.5*0.035-0.5*heightDeskFront,-0.02+0.001>}
        // Glasplatte
        object{
            Element(0.7-0.0002, depth-thk-0.0002, 0.01-0.0001, 0.0005)
            translate <wdth-0.7-thkSide-0.01-0.1-0.0001, 0.0005+thkDesk-0.01+0.0001, -(depth-0.5*thk+0.0001)>
                pigment { color rgbf<0.8,0.8,0.8,0.85> }
            material{
                interior{
                    ior 1.15
//                     fade_distance 2
//                     fade_power 2
//                     caustics 2.0
                }
            }
            finish {
                ambient 0.2
                diffuse 0.0
                reflection 0.1
                specular 0.0
                roughness 0.00001
            }
        }
        // Aufbewahrung
        object{
            union {
                union {
                    Round_Box_Y(<0,0,0>, <inset_wdth, inset_thk, inset_depth>, inset_rad_out, 0.4*inset_rad_out, 0.0, 0)
                    difference{
                        Round_Box(<0,0,0>, <inset_wdth, inset_thk+inset_rad_out+0.01, inset_depth>, inset_rad_out, 0)
                        object{
                            box{-1.1*inset_rad_out*<1,0,1>,<inset_wdth, inset_thk, inset_depth>+inset_rad_out*<1,1,1>*1.1}
                            translate y*inset_thk
                        }
                        object{
                            Round_Box(inset_rad_out*0.4*<1,0,1>, <inset_wdth, inset_thk, inset_depth>-inset_rad_out*0.4*<1,0,1>,inset_rad_out*(1-0.4),0)
                            translate y*(inset_thk-inset_rad_out*(1-0.4))
                        }
                        object{
                            Round_Box(inset_rad_out*2*0.4*<1,0,1>, <inset_wdth, inset_thk, inset_depth>-inset_rad_out*2*0.4*<1,0,1>,inset_rad_out*(1-2*0.4),0)
                            translate y*(inset_thk-0.01)
                        }
                    }
                    texture { t_metal_glossy_jvp }        
                }
                // Papierstapel
                #for (cntr, 0, 50)
                    object {
                        paper8
                        translate -<0.075, 0.00008, 0.105>*0.5
                        rotate 5*(random()-0.5)*y
                        translate <0.075, 0.00008, 0.105>*0.5
                        translate <0.015,0.005+cntr*0.00008*1.7, 0.015>+<random()-0.5,random()-0.5,random()-0.5>*0.007
                    }
                #end
                // Bleistift
                object {
                    Pencil(0.17)
                    translate -z*0.17*0.5
                    rotate y*7
                    translate z*0.17*0.5
                    translate<0.05,0.005, 0.015+0.105+0.17+0.0035+0.01>
                }
                translate <(thkSide+0.01),0, -depth>+inset_pos
            }
        }
        translate z*depth
    }
#end
#macro BoxInside(height, wdth, depth, thkTop, edgeTop, thkSide, heightDesk, heightDeskFront, thkDesk, thk, footHeight, footRad)
    union{
        object{
            Board(heightDesk - heightDeskFront - thkTop - footHeight + thk/2, depth-thk-0.003-0.01, thk, 0.0005) 
            rotate z*90
        }
        object{
            Board((wdth-2*thkSide)/3-0.5*thk, depth-thk-0.003-0.01, thk, 0.0005) 
            translate <-(thk + (wdth-2*thkSide)/3-0.5*thk),heightDesk - heightDeskFront - thkTop - footHeight - thk/2,0>
        }
    }
#end
#macro Drawer(height, wdth, depth, thk, edgeRad, heigthBox, wdthBox, thkBox, shift, handle)
    union {
        // Front
        difference {
            object{
                Element(wdth, height, thk, edgeRad) 
                TextureBoard()
                rotate -x*90
            }
            object{Element(0.12, 0.035, 3*thk, 0.00099)
                TextureBoard()
                rotate x*90 translate <wdth*0.5-0.06,height-0.0225,-1.3*thk>
            }
        }
        object{Handle(0.035, 0.12, 1, handle) 
        translate <wdth*0.5-0.06,height-0.035-0.0225,-0.02+0.001>}
        // Box
        union{
            // rechts
            object{
                Board(depth-thk, heigthBox, thkBox, 0.0005)
                rotate <-90,90,0>
                translate<thkBox,0,-thk>
            }
            // links
            object{
                Board(depth-thk, heigthBox, thkBox, 0.0005)
                rotate <-90,90,0>
                translate<wdthBox,0,-thk>
            }
            // Hinten
            object{
                Board(wdthBox-2*thkBox, heigthBox, thkBox, 0.0005) 
                rotate -x*90
                translate<thkBox,0,-depth+thkBox>
            }
            // Boden
            object{
                Board(wdthBox-2*thkBox, depth-thk-thkBox, 0.005, 0.0002) 
                translate <thkBox,0.003,-depth+thkBox>
            }
            translate shift
        }
    }
#end

#macro DoorOpn(wdth, thk, ornt, opn)
    #if (ornt)
        transform{
            translate -(x-z)*0.5*thk
            rotate -y*opn
            #local shift = vdot(vrotate((x+z)*(0.5*thk), -opn*y), z)-0.5*thk;
            translate (x-z)*(0.5*thk)+(x+z)*shift
        }
    #else
        transform{
            translate -wdth*x+(x+z)*0.5*thk
            rotate y*opn
            #local shift = vdot(vrotate((x+z)*(0.5*thk), -opn*y), z)-0.5*thk;
            translate wdth*x-(x+z)*(0.5*thk)+(-x+z)*shift
        }
    #end
#end
#macro Door(height, wdth, thk, edgeRad)
    object{
        Board(wdth, height, thk, edgeRad)
        rotate -x*90
    }
#end
#macro DoorTop(height, wdth, thk, edgeRad, ornt, opn)
    union {
        difference {
            Door(height, wdth, thk, edgeRad)
            object{Element(0.12, 0.035, 3*thk, 0.00099)
                rotate x*90 translate <wdth*0.5-0.06,0.035+0.0225,-1.3*thk>}
            TextureBoard()
        }
        object{
            Handle(0.035, 0.12, ornt, opn) 
            translate <wdth*0.5-0.06,0.0225,-0.02+0.001>
        }
    }
#end
//             FlapDoorTop(upperDoorHeight, frontElementWidth, thk, spacng, 1, tDoorRight)
#macro FlapDoorTop(height, wdth, thk, spacng, edgeRad, ornt, opnRel, opn_F, handle_F)
    union{
        object{
            DoorTop(height, wdth, thk, edgeRad, ornt, handle_F(opnRel))
        }
        object{
            DoorTop(height, wdth, thk, edgeRad, 1-ornt, handle_F(opnRel))
            translate <spacng*0.5,0,thk>
            rotate y*opn_F(opnRel)*2.0
            translate <spacng*0.5+wdth, 0, -thk>
        }
        DoorOpn(wdth, thk, ornt, opn_F(opnRel))
    }
#end

#macro DoorBtm(height, wdth, thk, edgeRad, ornt, opn)
    union {
        difference {
            Door(height, wdth, thk, edgeRad)
            object{Element(0.12, 0.035, 3*thk, 0.00099)
                rotate x*90 translate <wdth*0.5-0.06,height-0.0225,-1.3*thk>}
            TextureBoard()
        }
        object{
            Handle(0.035, 0.12, ornt, opn) 
            translate <wdth*0.5-0.06,height-0.035-0.0225,-0.02+0.001>
        }
    }
#end

#macro Desk01(height, wdth, depth, thkTop, edgeTop, thkSide, heightDesk, heightDeskFront, thkDesk, thk, spacng, footHeight, footRad, deskTop, drawer1, drawer2, drawer3, bDoorLeft, bDoorRight, tDoorLeft, tDoorRight)
    #local drawerPull = function(pull) {0.5*(1-cos(pi * max(0, min((2*pull-0.25)*4/3, 2-2*pull))))};
    #local handlePull = function(pull) {min(1, max(0, min(pull, 0.5-pull))*8)*30};
    union{
        // Korpus (corpus_01.pov)
        object{Corpus01(height, wdth, depth, thkTop, edgeTop, thkSide, heightDesk, heightDeskFront, thkDesk, thk, footHeight, footRad)}
        // Ventillator (fan.pov)
        object{
            AnimateFan(120, 20, 1, clock)
            rotate x*90
            translate <wdth-thkSide-0.2+0.06, 0.54+0.06,0.003>
        }
        // Schreibschublade
        #local distBack = 0.07;
        #local depthDeskTop = depth-0.003-0.01-distBack;
        object{
            #local deskTopPull = drawerPull(deskTop);
            #local h = handlePull(deskTop);
            union{
                    DeskTop(height, wdth, depthDeskTop, thkTop, edgeTop, thkSide, heightDeskFront, thkDesk, thk, footHeight, footRad, h) 
                    object {
                        paperA4
                        translate -0.5*<0.21,0,0.297>
                        rotate y*8
                        translate 0.5*<0.21,0,0.297>
                        translate <wdth-0.21-0.3,thkDesk+0.0005,depthDeskTop-0.291-0.04>
                    }
                    translate <0,heightDesk-thkDesk,0.003+0.01+distBack>
                    translate z*deskTopPull*(depthDeskTop-thk)
            }
        }
        // Bildschirm
        object{
            object{
                Display(42, 16/9, 0.14,-9)
                translate y*(heightDesk+0.01+thkDesk)
                translate <0.25,0,0.2>
            }
        }
        // Breite der Frontelemente
        #local frontElementWidth = (wdth-2*spacng)/3;
        // Schubladenkasten...
        union{
            // vertikal
            object{
                difference { // Aussparung fuer Kabel
                    object{
                        Element(heightDesk - heightDeskFront - thkTop - footHeight + thk/2, depth-thk-0.003-0.00-0.003, thk, 0.0005) 
                    }
                    cylinder{
                        <0.08,-0.01,0>,<0.08, 0.05,0>,0.045
                    }
                }
                TextureBoard()
                rotate z*90
            }
            // Deckel
            object{
                Board(frontElementWidth-(thkSide+thk-(0.5*(thk+spacng))), depth-thk-0.003-0.00-0.003, thk, 0.0005) 
                translate <-(frontElementWidth-(thkSide+thk-(0.5*(thk+spacng)))+thk),heightDesk - heightDeskFront - thkTop - footHeight - thk/2,0>
            }
            translate <frontElementWidth+0.5*(thk+spacng),footHeight+thkTop,0.003+0.00+0.003>
            #warning concat("inner drawer box with: ", str(frontElementWidth-(thkSide+thk-0.5*(thk+spacng)),5,4))
        }
        // 3 Schubladen
        #local depthDrawers = depth-0.003-0.04;
        object{
            union{
                Drawer(0.31, frontElementWidth, depthDrawers, thk, edgeTop, 0.24, frontElementWidth-(thkSide+0.005+0.5*thk+0.005), 0.015, <thkSide+0.005,0.01,0>, handlePull(drawer1))
                #local bar = object{
                    union{
                        object{
                            Round_Box(<-0.001,0.0,-0.5*thk>,<0.001,0.01,-(depthDrawers-0.01)>,0.0009,0)
                            translate y*0.01
                        }
                        Round_Box(<-0.005,0.0,-(depthDrawers-0.01)>,<0.005,0.021,-(depthDrawers-0.012)>,0.0009,0)
                    }
                    texture { 
                        pigment{ color rgb<1,1,1>*0.1
                        }
                        finish { 
                            ambient 0.4 
                            diffuse 0.6 
                            reflection 0.04
                        }
                    }
                };
                object{
                    bar
                    translate y*0.25+x*(thkSide+0.005+0.015)
                }
                object{
                    bar
                    translate y*0.25+x*(thkSide+0.005+0.015+0.33)
                }
                #for (id, 0, 9, 1)
                    object{ 
                        Register(mod(id,5))
                        translate -z*(0.07+0.01*id)+y*(0.25+0.02)+x*(thkSide+0.005+0.015)
                    }
                #end
            }
            translate <0,footHeight+thkTop+spacng,depth>
            translate z*drawerPull(drawer1) * depthDrawers
            #warning concat("inner drawer width: ", str(frontElementWidth-(thkSide+0.005+0.5*thk+0.005+2*0.015), 5, 4))
        }
        #local lo_drawer_height = (heightDesk - (heightDeskFront + 4*spacng+footHeight+thkTop+0.31))/2;
        #warning concat("upper two drawer's height: ", str(lo_drawer_height, 5, 4))
        object{
            Drawer(lo_drawer_height, frontElementWidth, depthDrawers, thk, edgeTop, lo_drawer_height-0.02, frontElementWidth-(thkSide+0.005+0.5*thk+0.005), 0.015, <thkSide+0.005,0.01,0>, handlePull(drawer2))
            translate <0,footHeight+thkTop+2*spacng+0.31,depth>
            translate z*drawerPull(drawer2) * depthDrawers
        }
        object{
            Drawer(lo_drawer_height, frontElementWidth, depthDrawers, thk, edgeTop, lo_drawer_height-0.02, frontElementWidth-(thkSide+0.005+0.5*thk+0.005), 0.015, <thkSide+0.005,0.01,0>, handlePull(drawer3))
            translate <0,footHeight+thkTop+3*spacng+0.31+lo_drawer_height,depth>
            translate z*drawerPull(drawer3) * depthDrawers            
        }
        
        // zwei Türen (unten)
        #local lowerDoorHeight = (heightDesk - (heightDeskFront + 2*spacng+footHeight+thkTop));
        #warning concat("lower door's height: ", str(lowerDoorHeight, 5, 4))
        object{
            DoorBtm(lowerDoorHeight, frontElementWidth, thk, edgeTop, 0, handlePull(bDoorLeft))
            DoorOpn(frontElementWidth, thk, 0, 90*drawerPull(bDoorLeft))
            translate <wdth-frontElementWidth, footHeight+thkTop+spacng, depth>
        }
        object{
            DoorBtm(lowerDoorHeight, frontElementWidth, thk, edgeTop, 1, handlePull(bDoorRight))
            DoorOpn(frontElementWidth, thk, 1, 90*drawerPull(bDoorRight))
            translate <wdth-2*frontElementWidth-spacng, footHeight+thkTop+spacng, depth>
        }
        
        // Türen oben
        #local upperDoorHeight = height - (thkTop + heightDesk + 2*spacng);
        object{
            DoorTop(upperDoorHeight, frontElementWidth, thk, edgeTop, 0, handlePull(tDoorLeft))
            DoorOpn(frontElementWidth, thk, 0, 90*drawerPull(tDoorLeft))
            translate <wdth-frontElementWidth, height-(thkTop+spacng)-upperDoorHeight, depth>
        }       
        object{
            FlapDoorTop(upperDoorHeight, frontElementWidth, thk, edgeTop, spacng, 1, tDoorRight, function(x){90*drawerPull(tDoorRight)}, handlePull)
            translate <wdth-3*frontElementWidth-2*spacng, height-(thkTop+spacng)-upperDoorHeight, depth>
        }       
        object{
            MakeGlass(0.2,color rgbf <0.5, 0.005, 0.2,0.8>,0)      
            scale 0.007
            translate <0.5,height,0.35>
        }
        // Unten im Schrank ...
        object{
            Round_Box(<0,0,0>,<0.5, 0.545, 0.23>, 0.03, 0)
            texture { pigment { color rgb 0.1*<1,1,1> }}
            translate <wdth-0.2-0.6, footHeight+thkTop, 0.01>
        }
    }
#end
