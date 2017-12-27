#include "corpus_01.pov" 
#include "dimensions_01.pov"

camera
{
  location  <0.575, 1.0, 0.1>
  look_at   <1, 0.7,0.05>
}

object{Corpus01(Height, Wdth, Depth, ThkTop, EdgeTop, ThkSide, HeightDesk, HeightDeskFront, ThkDesk, Thk, FootHeight, FootRad)}

