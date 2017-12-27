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

#declare Random_1 = seed (1153);

global_settings{
    assumed_gamma 1 // change if the image is too pale

    radiosity{
        recursion_limit 1
    }
  max_trace_level 8
} 
 

#include "woods.inc"

#declare light_woodT = pigment { P_WoodGrain16A color_map { M_Wood7A } scale 0.1 }
#declare  dark_woodT = pigment { P_WoodGrain14A color_map { M_Wood14A } scale 0.1}
#declare board_lengthT = 2.0;
#declare board_widthT = 0.06;

// ----------------------------------------
// Tables
// ----------------------------------------
// Table 1
// ----------------------------------------
#declare C_Table=rgb <1, 0.40297, 0.10703>;
#declare C_Table2=rgb <1, 0.65297, 0.30703>;
#declare C_PTable2=rgb <0.5, 0.25781, 0.13672>*0.1;

#macro T_TableWood2()
    texture{
          pigment { gradient y triangle_wave
                pigment_map { [0 light_woodT ]
                              [1 dark_woodT ] }
                warp { repeat board_lengthT*z offset 0.371*y } 
                warp { repeat board_widthT*x offset board_lengthT*2*pi*z } 
//                 warp { repeat board_widthT*x offset board_lengthT*2*pi*z } 
//                 warp { repeat board_widthT*x offset board_lengthT*z } 
                rotate y*90
                translate y*rand(Random_1)*7
                }
    }            
#end
#declare T_TableCorner1=texture{
    pigment{C_Table*0.01}
    finish{ambient 0 diffuse 1 specular 1 roughness 0.01}
}
#declare T_TableCorner2=texture{
    pigment{White*0.8}
    finish{ambient 0 diffuse 1 metallic brilliance 3 specular 1 roughness 0.01 reflection 0.2}
}
                  
// ----------------------------------------
// Table 2
// ----------------------------------------

#macro Element(lngth, wdth, thk, edge) 
    Round_Box(<0,0,0>, <lngth, thk, wdth>, edge, 1)
#end

#include "register.pov"

#macro Element2(lngth, wdth, thk, edge) 
//union{
    #declare xTable=lngth;
    #declare yTable=thk;
    #declare zTable=wdth;
    #declare aTable=edge;
    #declare rTable=edge*1.01;
    #declare eTable=thk;
    #declare xTable2=xTable-2*rTable;
    #declare zTable2=zTable-2*rTable;
    /*#declare rPTable=0.0016;
    #declare aPTable=0.009;
    #declare rPTable2=0.007;
    #declare yPTable=yTable-eTable-rPTable-aPTable;
    #declare xPTable=xTable-2*rPTable2-2*aPTable;
    #declare zPTable=zTable-2*rPTable2;*/
    union{ // top
        box{<0,eTable*0.5,0>,<xTable2,eTable,zTable2> translate <rTable,0,rTable>} // centre dessus
        box{<0,0,0>,<xTable2,eTable*0.5,zTable2> translate <rTable,0,rTable>} //texture{pigment{C_Table*0.1} finish{ambient 0 diffuse 1}}} // centre dessous
        #declare TableBord=union{ // side
            box{<0,aTable,0>,<aTable,eTable-aTable,1>}
            box{0,<rTable-aTable,eTable,1> translate x*aTable}
            cylinder{0,z,aTable translate <aTable,eTable-aTable,0>}
            cylinder{0,z,aTable translate <aTable,aTable,0>}
        }
        #declare TableCorner=difference{ // Corner
            union{
                cylinder{y*aTable,y*(eTable-aTable),rTable}
                cylinder{0,y*aTable,rTable-aTable translate y*(eTable-aTable)}
                cylinder{0,y*aTable,rTable-aTable}
                torus{rTable-aTable,aTable translate y*(eTable-aTable)}
                torus{rTable-aTable,aTable translate y*aTable}
            }
            plane{x,0 inverse}
            plane{z,0 inverse}
        }
        
        union{
            object{TableBord scale <1,1,zTable2>}
            object{TableBord scale <-1,1,zTable2> translate x*(xTable2+2*rTable)}
            translate z*rTable
        }

        union{
            object{TableBord rotate y*90 scale <xTable2,1,-1>}
            object{TableBord rotate y*90 scale <xTable2,1,1> translate z*(zTable2+2*rTable)}
            translate x*rTable
        }
        
        object{TableCorner translate <rTable,0,rTable>}
        object{TableCorner scale <-1,1,1> translate <rTable+xTable2,0,rTable>}
        object{TableCorner scale <1,1,-1> translate <rTable,0,zTable2+rTable>}
        object{TableCorner scale <-1,1,-1> translate <rTable+xTable2,0,zTable2+rTable>}
        translate y*(yTable-eTable)
    }

//}  
#end

#macro Board(lngth, wdth, thk, edge) 
    object{Element(lngth, wdth, thk, edge)
         T_TableWood2()
    }
#end



#declare light_woodF = pigment { P_WoodGrain16A color_map { M_Wood7A } scale 0.1 }
#declare  dark_woodF = pigment { P_WoodGrain14A color_map { M_Wood8A } scale 0.1}
#declare board_lengthF = 0.35;
#declare board_widthF = 0.075;

#declare light_Wallpaper = pigment { P_WoodGrain16A color <1,1,1> scale 10 }

plane{y,0 
          pigment { gradient y sine_wave
                pigment_map { [0.2 light_woodF ]
                              [1.0 dark_woodF ] }
                warp { repeat board_lengthF*z offset 0.37*y } 
                warp { repeat board_widthF*x offset board_lengthF*3/2*z } 
                rotate y*45
                }
}
plane{x,2
          pigment { gradient y sine_wave
                pigment_map { [1 light_Wallpaper ] }
                }
}
plane{z,-2
          pigment { gradient y sine_wave
                pigment_map { [1 light_Wallpaper ] }
                }
}

// ----------------------------------------
// Scene
// ----------------------------------------

#macro straightRotate(vec, dir1, dir2)
    dir1+vrotate(vec-dir1, dir2)
#end

// #declare clock_ = clock;
#declare clock_=15;

background{White*0.5}
light_source{x*100 color White
    area_light 15*x,15*z, 10,10 jitter adaptive 1 orient
    rotate z*45
    rotate y*210
}

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
        T_TableWood2()
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
            T_TableWood2()
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
