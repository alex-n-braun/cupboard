#include "scene_standard.pov"
#include "desk_01.pov" 
#include "dimensions_01.pov"

camera
{
  location  <0.175, 1.0, 2.1>
  look_at   <0.55, 0.8,0.6>
}

#macro Desk01Inst1(deskTop, drawer1, drawer2, drawer3, bDoorLeft, bDoorRight, tDoorLeft, tDoorRight)
    object{
        Desk01(Height, 
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

object{Desk01Inst1(0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0)}
