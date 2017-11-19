//==========================================
// Classroom furniture
// -----------------------------------------
// Made for Persistence of vision 3.6
// =========================================
// Copyright 2001-2004 Gilles Tran http://www.oyonale.com
// -----------------------------------------
// This work is licensed under the Creative Commons Attribution License. 
// To view a copy of this license, visit http://creativecommons.org/licenses/by/2.0/ 
// or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.
// You are free:
// - to copy, distribute, display, and perform the work
// - to make derivative works
// - to make commercial use of the work
// Under the following conditions:
// - Attribution. You must give the original author credit.
// - For any reuse or distribution, you must make clear to others the license terms of this work.
// - Any of these conditions can be waived if you get permission from the copyright holder.
// Your fair use and other rights are in no way affected by the above. 
// ==========================================  

#include "colors.inc"
#include "glass.inc"
#include "textures.inc"
#include "shapes.inc"
#include "shapes3.inc"

#include "Round_Box_Y.inc"
#include "mdrink.pov"

#include "metal.pov"

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

#declare m_width=1.2;
#declare m_tot_depth=0.5;
#declare m_joint=0.002;  // fugen

#declare m_sides_thickness=0.02;  // dicke seitenwaende
#declare m_front_thickness=0.02;  // dicke der frontplatten
#declare m_back_dist=0.01;  // rueckseite: wieviel nimmt sie vom innenraum weg?

#declare m_desk_height=0.76;  // hoehe der Oberflaeche der Ausziehschublade
#declare m_desk_thickness=0.02; // dicke der schreibschublade
#declare m_desk_fittings=0.01;  // beschlaege
#declare m_desk_dist=0.005;  // abstand oben
#declare m_desk_frontheight=0.024; // hoehe schubladenfront
#declare m_desk_boardwidth=m_width-2*(m_sides_thickness+m_desk_fittings);
#declare m_desk_boarddepth=m_tot_depth-m_front_thickness-m_back_dist-0.1;  // platte ist verkuerzt wg. kabelschacht


// ----------------------------------------
// Scene
// ----------------------------------------


#declare Height = 1.30;
#declare Wdth = 1.255;
#declare Depth = 0.49;
#declare ThkTop = 0.03;
#declare EdgeTop = 0.002;
#declare ThkSide = 0.04;
#declare ThkDesk = 0.03;
#declare HeightDesk = 0.76;
#declare HeightDeskFront = 0.08;
#declare Thk = 0.02;
#declare FootHeight = 0.0625;
#declare FootRad = 0.025;
#declare Spacng = 0.002;


#macro straightRotate(vec, dir1, dir2)
    dir1+vrotate(vec-dir1, dir2)
#end

// #declare clock_ = clock;
#declare clock_=15;

camera
{
// #1 von vorne animiert
//   location  straightRotate(<-0.74, 0.12+0.11*clock, 0.>, 0.5*<Wdth, 0, Depth>, y*(130-3.5*clock))
//   look_at   <0.6, 0.52+0.02*clock,0.4>
// #2 registerschublade
//   location  straightRotate(<0.15, 0.30+0.03*clock_,0.675>-<0.3, 0.0, 0.0>, <0.15, 0.45,0.675>, y*(-30+3.5*clock_))
//   look_at   <0.15, 0.45,0.675>
// von vorne 
  location  <0.075, 0.5, 1.4>
  look_at   <0.25, 0.3,0.6>
//  location  <0.8, 1.82, 1.8>
// von hinten
//  location  <0.2,0.46,-0.5>
//  look_at <0.6, 0.1, 0>
// von der Seite rechts
//     location  <-0.14, 1., Depth-Thk>
//     look_at   <1., 1., Depth-Thk>
// von oben, rechts vorne
//     location <0, Height+0.5, Depth>
//     look_at <0, 0, Depth>
// von der Seite links
//     location  <Wdth+0.14, 1., Depth-Thk>
//     look_at   <1.-Wdth, 1., Depth-Thk>
// von oben, links vorne
//     location <Wdth, Height+0.5, Depth>
//     look_at <Wdth, 0, Depth>
// über schreibschublade
//     location <0.25, 1, 0.8>
//     look_at <0.2, 0.76, 0.7>
}
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

#macro Display(diag_inch, aspect_ratio, elevation, rot)
    #local display_thk = 0.05;
    #local display_corner = 0.02;
    #local display_length = diag_inch*2.54*0.01*aspect_ratio/sqrt(pow(aspect_ratio,2)+1);
    #local display_dim = diag_inch*2.54*0.01*<aspect_ratio, 0, 1>/sqrt(pow(aspect_ratio,2)+1) + y*display_thk;
    union{
        union{
            // Display
            difference {
                Round_Box(<0,0,0>, display_dim, display_corner, 0)
                box{<-0.1,display_thk-display_corner,-0.1>,display_dim+<0.1,0.1,0.1>}
                Round_Box(<display_corner,display_thk-display_corner-0.003,display_corner>, display_dim-<display_corner,-0.1,display_corner>, 0.03*display_corner, 0)
                texture { 
                    pigment { color rgb <1,1,1>*0.6 } 
                    finish { ambient 0.4 diffuse 0.6 }
                }
            }
            box{
                <display_corner,display_thk-display_corner-0.003,display_corner>, (display_dim-<display_corner,display_corner+0.002,display_corner>)
                texture { 
                    pigment { color rgb <1,1,1>*0.025 } 
                    finish { 
                        ambient 0.4 diffuse 0.6 
                        reflection 0.02
                        specular 0.0
                        roughness 0.00001
                    }
                }
            }
            rotate x*80
            translate y*(vdot(display_dim, <0,0,1>)+elevation)
            translate -z*0.04
        }
        // Fuss
        union {
            #local foot_length = display_length*0.5;
            object{
                Round_Box(<0,0,0>,<foot_length, 0.013, 0.12>,0.002, 0)
            }
            object{
                Round_Box(<0,0,0>,<0.4*foot_length, display_length/aspect_ratio*0.75,0.025>,0.005, 0)
                translate x*0.5*(foot_length-0.4*foot_length)+z*0.005
            }
            texture { 
                pigment { color rgb <1,1,1>*0.6 } 
                finish { ambient 0.4 diffuse 0.6 }
            }
            translate <0.5*foot_length,0,-0.5*0.12>
        }
        translate -0.5*x*display_length
        rotate y*rot
        translate 0.5*x*display_length
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
            T_TableWood2()
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
            T_TableWood2()
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
                        rotate 5*(rand(Random_1)-0.5)*y
                        translate <0.075, 0.00008, 0.105>*0.5
                        translate <0.015,0.005+cntr*0.00008*1.7, 0.015>+<rand(Random_1)-0.5,rand(Random_1)-0.5,rand(Random_1)-0.5>*0.007
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
#macro DeskInside(height, wdth, depth, thkTop, edgeTop, thkSide, heightDeskFront, thkDesk, thk, footHeight, footRad)
        object{Board(wdth-2*thkSide, depth-thk, thkDesk, 0.0005)
            translate <thkSide,0,0>}
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
                T_TableWood2()
                rotate -x*90
            }
            object{Element(0.12, 0.035, 3*thk, 0.00099)
                T_TableWood2()
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
#macro FlapDoorOpn(wdth, thk, ornt, opn)
    transform{
        #if (ornt)
            translate -(x-z)*0.5*thk
            rotate y*opn
            #local shift = vdot(vrotate((x+z)*(0.5*thk), -opn*y), z)-0.5*thk;
            translate (x-z)*(0.5*thk)+(x+z)*shift
            translate vrotate(<wdth, 0, 0>, -y*opn)-x*wdth
//             translate z*thk
//             rotate y*opn
//             translate -z*thk
//             #local shift = vdot(vrotate((x+z)*(0.5*thk), -opn*y), z)-0.5*thk;
//             translate (x+z)*shift+vrotate(<wdth-thk, 0, 0>, -y*opn)-x*(wdth-thk)
        #else
        #end
    }
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
            T_TableWood2()
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
            T_TableWood2()
        }
        object{
            Handle(0.035, 0.12, ornt, opn) 
            translate <wdth*0.5-0.06,height-0.035-0.0225,-0.02+0.001>
        }
    }
#end



#macro Desk(height, wdth, depth, thkTop, edgeTop, thkSide, heightDesk, heightDeskFront, thkDesk, thk, spacng, footHeight, footRad, deskTop, drawer1, drawer2, drawer3, bDoorLeft, bDoorRight, tDoorLeft, tDoorRight)
    #local drawerPull = function(pull) {0.5*(1-cos(pi * max(0, min((2*pull-0.25)*4/3, 2-2*pull))))};
    #local handlePull = function(pull) {min(1, max(0, min(pull, 0.5-pull))*8)*30};
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
                    Board(wdth-2*thkSide, height-thkTop*2-footHeight, 0.001, 0.0004)            
                    rotate x*90 translate <thkSide, height-thkTop, 0.003>
                }
                box{<0.04+thkSide,0.54,0>,<0.04+thkSide+0.1, 0.54+0.1, 0.006>}
            }
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
        // oberhalb...
        difference{
            object{DeskInside(height, wdth, depth, thkTop, edgeTop, thkSide, heightDeskFront, thkDesk, thk, footHeight, footRad) translate (heightDesk+0.01)*y}
        }
        // Bildschirm
        object{
            object{
                Display(32, 16/9, 0.06,-9)
                translate y*(heightDesk+0.01+thkDesk)
                translate <0.4,0,0.2>
            }
        }
        // Breite der Frontelemente
        #local frontElementWidth = (wdth-2*spacng)/3;
        // Schubladenkasten...
        union{
            object{
                Board(heightDesk - heightDeskFront - thkTop - footHeight + thk/2, depth-thk-0.003-0.01, thk, 0.0005) 
                rotate z*90
            }
            object{
                Board(frontElementWidth-(thkSide+thk-(0.5*(thk+spacng))), depth-thk-0.003-0.01, thk, 0.0005) 
                translate <-(frontElementWidth-(thkSide+thk-(0.5*(thk+spacng)))+thk),heightDesk - heightDeskFront - thkTop - footHeight - thk/2,0>
            }
            translate <frontElementWidth+0.5*(thk+spacng),footHeight+thkTop,0.003+0.01>
            #warning concat("inner drawer box with: ", str(frontElementWidth-(thkSide+thk-0.5*(thk+spacng)),5,4))
        }
        // 3 Shubladen
        #local depthDrawers = depth-0.003-0.01;
//         object{
//             union{
//                 Drawer(0.31, frontElementWidth, depthDrawers, thk, edgeTop, 0.24, frontElementWidth-(thkSide+0.005+0.5*thk+0.005), 0.015, <thkSide+0.005,0.01,0>, handlePull(drawer1))
//                 #local bar = object{
//                     union{
//                         object{
//                             Round_Box(<-0.001,0.0,-0.5*thk>,<0.001,0.01,-(depthDrawers-0.01)>,0.0009,0)
//                             translate y*0.01
//                         }
//                         Round_Box(<-0.005,0.0,-(depthDrawers-0.01)>,<0.005,0.021,-(depthDrawers-0.012)>,0.0009,0)
//                     }
//                     texture { 
//                         pigment{ color rgb<1,1,1>*0.1
//                         }
//                         finish { 
//                             ambient 0.4 
//                             diffuse 0.6 
//                             reflection 0.04
//                         }
//                     }
//                 };
//                 object{
//                     bar
//                     translate y*0.25+x*(thkSide+0.005+0.015)
//                 }
//                 object{
//                     bar
//                     translate y*0.25+x*(thkSide+0.005+0.015+0.33)
//                 }
//                 #for (id, 0, 9, 1)
//                     object{ 
//                         Register(mod(id,5))
//                         translate -z*(0.07+0.01*id)+y*(0.25+0.02)+x*(thkSide+0.005+0.015)
//                     }
//                 #end
//             }
//             translate <0,footHeight+thkTop+spacng,depth>
//             translate z*drawerPull(drawer1) * depthDrawers
//             #warning concat("inner drawer width: ", str(frontElementWidth-(thkSide+0.005+0.5*thk+0.005+2*0.015), 5, 4))
//         }
//         #local lo_drawer_height = (heightDesk - (heightDeskFront + 4*spacng+footHeight+thkTop+0.31))/2;
//         #warning concat("upper two drawer's height: ", str(lo_drawer_height, 5, 4))
//         object{
//             Drawer(lo_drawer_height, frontElementWidth, depth-0.003-0.01, thk, edgeTop, lo_drawer_height-0.02, frontElementWidth-(thkSide+0.005+0.5*thk+0.005), 0.015, <thkSide+0.005,0.01,0>, handlePull(drawer2))
//             translate <0,footHeight+thkTop+2*spacng+0.31,depth>
//             translate z*drawerPull(drawer2) * depthDrawers
//         }
//         object{
//             Drawer(lo_drawer_height, frontElementWidth, depth-0.003-0.01, thk, edgeTop, lo_drawer_height-0.02, frontElementWidth-(thkSide+0.005+0.5*thk+0.005), 0.015, <thkSide+0.005,0.01,0>, handlePull(drawer3))
//             translate <0,footHeight+thkTop+3*spacng+0.31+lo_drawer_height,depth>
//             translate z*drawerPull(drawer3) * depthDrawers            
//         }
        
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

//object{Desk(Height, Wdth, Depth, ThkTop, EdgeTop, ThkSide, HeightDesk, HeightDeskFront, ThkDesk, Thk, Spacng, FootHeight, FootRad, 0,0,0,0,0,0,0,0)}


//object{DeskInside(Height, Wdth, Depth, ThkTop, EdgeTop, ThkSide, HeightDeskFront, ThkDesk, Thk, FootHeight, FootRad) translate (0.77)*y}
//object{BoxInside(Height, Wdth, Depth, ThkTop, EdgeTop, ThkSide, HeightDesk, HeightDeskFront, ThkDesk, Thk, FootHeight, FootRad) translate<ThkSide+Thk+(Wdth-2*ThkSide-2*Thk)/3, FootHeight+ThkTop,0.003+0.01>}

// object{Drawer(0.2, 0.3, 0.45, 0.02, 0.002, 0.14, 0.25, 0.015, <0.02,0.02,0>)}
// object{Drawer(0.2, 0.3, 0.45, 0.02, 0.002, 0.14, 0.25, 0.015, <0.02,0.02,0>)
// translate <0,0.205,-0.2>}
//object{Door(0.5, 0.3, 0.02, 0.005) translate <0,0,0.7>}

#macro DeskInst1(deskTop, drawer1, drawer2, drawer3, bDoorLeft, bDoorRight, tDoorLeft, tDoorRight)
    object{
        Desk(Height, 
             Wdth, 
             Depth, 
             ThkTop, 
             EdgeTop, 
             ThkSide, 
             HeightDesk, 
             HeightDeskFront, 
             ThkDesk, 
             Thk, 
             Spacng, 
             FootHeight, 
             FootRad, 
             deskTop, 
             drawer1, 
             drawer2, 
             drawer3, 
             bDoorLeft, 
             bDoorRight, 
             tDoorLeft, 
             tDoorRight)
    }
#end
// #1
//object{DeskInst1(min(0.5, 0.25*(clock-10)),0,0,min(0.5, 0.25*(clock-11)),min(0.5, 0.5*(clock-2)),min(0.5, 0.25*(clock-3)),min(0.5,0.25*(clock-7)),min(0.5, 0.25*(clock-8)))}
// #2
//object{DeskInst1(0.5,max(0.5,0.5+0.5*0.25*(clock_-9)),0.5,0,0.0,0.0,0.,0.)}
object{DeskInst1(0,0,0,0,0.5,0.5,0,0)}
