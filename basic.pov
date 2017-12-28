#macro straightRotate(vec, dir1, dir2)
    dir1+vrotate(vec-dir1, dir2)
#end

#macro Element(lngth, wdth, thk, edge) 
    Round_Box(<0,0,0>, <lngth, thk, wdth>, edge, 1)
#end

#declare Random_1 = seed (1153);

#macro random()
    rand(Random_1)
#end

#include "woods.inc"

#declare light_woodT = pigment { P_WoodGrain16A color_map { M_Wood7A } scale 0.1 }
#declare  dark_woodT = pigment { P_WoodGrain14A color_map { M_Wood14A } scale 0.1}
#declare board_lengthT = 2.0;
#declare board_widthT = 0.06;

#macro TextureBoard()
    texture{
          pigment { gradient y triangle_wave
                pigment_map { [0 light_woodT ]
                              [1 dark_woodT ] }
                warp { repeat board_lengthT*z offset 0.371*y } 
                warp { repeat board_widthT*x offset board_lengthT*2*pi*z } 
                rotate y*90
                translate y*random()*7
                }
    }            
#end

#macro Board(lngth, wdth, thk, edge) 
    object{Element(lngth, wdth, thk, edge)
         TextureBoard()
    }
#end

