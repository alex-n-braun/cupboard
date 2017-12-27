#include "corpus_01.pov" 
#include "dimensions_01.pov"

camera
{
// #1 von vorne animiert
//   location  straightRotate(<-0.74, 0.12+0.11*clock, 0.>, 0.5*<Wdth, 0, Depth>, y*(130-3.5*clock))
//   look_at   <0.6, 0.52+0.02*clock,0.4>
// #2 registerschublade
//   location  straightRotate(<0.15, 0.30+0.03*clock_,0.675>-<0.3, 0.0, 0.0>, <0.15, 0.45,0.675>, y*(-30+3.5*clock_))
//   look_at   <0.15, 0.45,0.675>
// von vorne 
  location  <0.175, 1.0, 2.1>
  look_at   <0.35, 0.7,0.6>
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

object{Corpus01(Height, Wdth, Depth, ThkTop, EdgeTop, ThkSide, HeightDesk, HeightDeskFront, ThkDesk, Thk, FootHeight, FootRad)}

