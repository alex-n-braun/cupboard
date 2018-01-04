#include "scene_standard.pov"
#include "desk_01.pov" 
#include "dimensions_01.pov"

#declare clock_ = clock;

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

object{Desk01Inst1(min(0.5, 0.25*(clock-10)),0,0,min(0.5, 0.25*(clock-11)),min(0.5, 0.5*(clock-2)),min(0.5, 0.25*(clock-3)),min(0.5,0.25*(clock-7)),min(0.5, 0.25*(clock-8)))}

//object{DeskInst1(min(0.5, 0.25*(clock-10)),0,0,min(0.5, 0.25*(clock-11)),min(0.5, 0.5*(clock-2)),min(0.5, 0.25*(clock-3)),min(0.5,0.25*(clock-7)),min(0.5, 0.25*(clock-8)))}
// #2
//object{DeskInst1(0.5,max(0.5,0.5+0.5*0.25*(clock_-9)),0.5,0,0.0,0.0,0.,0.)}
