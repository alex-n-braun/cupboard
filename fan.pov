//==========================================
// Display example
// -----------------------------------------
// Made for Persistence of vision 3.7
// =========================================
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

#macro Fan(wdth_mm, depth_mm) 
    // axis
    #local rad=0.5*wdth_mm/1000;
    #local rad_axis=rad/6;
    #local depth=depth_mm/1000;
    union{
        cylinder{
            <0,0,0>,
            <0,depth,0>,
            rad_axis
        }
        union{
            #local thk=0.8/1000;
            #for (i_alpha, 0, 5)
                object{
                    cylinder{
                        <depth/2,0,-thk/2>,<depth/2,0,thk/2>,
                        depth/2
                    }
                    scale<(rad)/depth,1,1>
                    matrix<1,0,0, 0,1,1.5, 0,0,1, 0,0,0>
                    translate y*depth/2
                    rotate y*i_alpha*60
                }
            #end
        }
        texture { 
            pigment { color rgb <1,1,1>*0.4 } 
            finish { ambient 0.4 diffuse 0.6 }
        }
    }
#end

#macro AnimateFan(wdth_mm, depth_mm, frequ, time_)
    object{
        Fan(wdth_mm, depth_mm)
        rotate -y*time_*frequ*360
    }
#end
