#include "scene_standard.pov"
#include "corpus_01.pov" 
#include "dimensions_01.pov"

camera
{
  location  <0.175, 1.0, 2.1>
  look_at   <0.55, 0.8,0.6>
}

object{Corpus01(Height, Wdth, Depth, ThkTop, EdgeTop, ThkSide, HeightDesk, HeightDeskFront, ThkDesk, Thk, FootHeight, FootRad)}

