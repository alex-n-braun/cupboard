#include "fan.pov" 

#include "woods.inc"

camera
{
// von vorne
 location  <0.0,0.46,0.9>
 look_at <0.3, 0.1, 0>
}

background{White*0.5}
light_source{x*100 color White
    area_light 15*x,15*z, 10,10 jitter adaptive 1 orient
    rotate z*45
    rotate y*210
}


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

object{AnimateFan(120, 20, 1, clock)}

