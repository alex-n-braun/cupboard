#include "scene_standard.pov"
#include "desk_01.pov" 
#include "dimensions_01.pov"

#declare clock_ = clock;

camera
{
// #1 von vorne animiert
  location  straightRotate(<-0.74, 0.12+0.11*(15.0-clock_), 0.>, 0.5*<Wdth, 0, Depth>, y*(130-3.5*(15-clock_)))
  look_at   <0.6, 1.3-clock_/20,0.4>
//   location  <0.175, 1.0, 2.1>
//   look_at   <0.55, 0.8,0.6>
}

// #1 von vorne animiert
//   location  straightRotate(<-0.74, 0.12+0.11*clock, 0.>, 0.5*<Wdth, 0, Depth>, y*(130-3.5*clock))
//   look_at   <0.6, 0.52+0.02*clock,0.4>
// #2 registerschublade
//   location  straightRotate(<0.15, 0.30+0.03*clock_,0.675>-<0.3, 0.0, 0.0>, <0.15, 0.45,0.675>, y*(-30+3.5*clock_))
//   look_at   <0.15, 0.45,0.675>

#macro Corpus01Inst1(deskTop)
    object{
        Corpus01(Height, 
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
             FootRad)
    }
#end

object{Corpus01Inst1(0)}

//object{DeskInst1(min(0.5, 0.25*(clock-10)),0,0,min(0.5, 0.25*(clock-11)),min(0.5, 0.5*(clock-2)),min(0.5, 0.25*(clock-3)),min(0.5,0.25*(clock-7)),min(0.5, 0.25*(clock-8)))}
// #2
//object{DeskInst1(0.5,max(0.5,0.5+0.5*0.25*(clock_-9)),0.5,0,0.0,0.0,0.,0.)}
