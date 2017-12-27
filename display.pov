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
