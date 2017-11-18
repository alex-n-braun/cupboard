//==========================================
// Half-full glass 
// -----------------------------------------
// This glass was used in "The Cubicle Workers" ("La vie de bureau")
// and "The Drink" ("Le verre de l'amitié").
// -----------------------------------------
// Made for Persistence of vision 3.6
//==========================================  
// Copyright 1998-2004 Gilles Tran http://www.oyonale.com
// -----------------------------------------
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
//=========================================
// MakeGlass macro
//-----------------------------------------
#macro MakeGlass(eGlass,C_Liquid,dotest)
// C_Liquid = color of liquid
// eGlass = glass thickness
// dotest= test flag 0=no test 1=test
//-----------------------------------------

#local eps=0.001;
union{
// Glass
        lathe{
            cubic_spline
            22, // # of points
            <-0.5,0.1>,<0,0>,<4.6,0>,<4.4,0.5>,<1.5,0.7>,<0.8,1.8>,<1.3,2.5>,
            <1,3>,<0.8,4>,<1,5>,<3,6.5>,<4.5,8>,<5.2,10>,<5,12>,<4.8,15>,
            <4.3,14.7>,<5-eGlass,12>,<5.2-eGlass,10>,<4.5-eGlass,8>,<3-eGlass,6.5>,
            <0,5.4>,<-1,5.4>
            //sturm
            #if (dotest=1)
                texture{pigment{rgbf <0.8,0.8,0.8,0.9>} finish{phong 1}}
            #else
                texture{
                    pigment{Clear}
                    finish{
                        reflection {0.1,0.3} 
                        //conserve_energy 
                        ambient 0 diffuse 0  
                        specular 0.6 roughness 1/1000
                    }                                        
                }     
                interior{ior 1.5}// fade_power 2 fade_distance 2}
            #end
            photons{
                target
                refraction on
                reflection on
            }
        }
// vodka, cognac whatever
        lathe{
            cubic_spline
            9, // # of points
            <-1,11.5>,<0,11.5>,<3.9-eps,11.7>,<5-eGlass-eps,12>,<5.2-eGlass-eps,10>,
            <4.5-eGlass-eps,8>,<3-eGlass-eps,6.5>,<0,5.4+eps>,<-1,5.4+eps>
            //sturm   
            #if (dotest=1)
                texture{pigment{rgb<1,0,0>}}
            #else
                texture{
                    pigment{C_Liquid}
                    finish{
                        reflection {0.1,0.3}
                        //conserve_energy 
                        ambient 0 diffuse 0 
                        specular 0.4 roughness 1/1000
                    }
                }
                interior{ior 1.33 fade_power 2 fade_distance 2}
            #end
            photons{
                target
                refraction on
                reflection on
            }
        }     
}
#end

//=========================================
// Glass example
//-----------------------------------------
/*
#include "colors.inc"
global_settings{
    assumed_gamma 1
    max_trace_level 10
    photons {
        count 300000
        autostop 0
        jitter .4
    }
    adc_bailout 1/10
}
//global_settings{max_trace_level 5}
#declare PdV=<0, 20, -30>*2;
camera {
    location  PdV   
    right 4*x/3   
    up y  
    direction z*2 
    look_at 5*y
}

light_source { 
    -z*100
    White
    rotate x*45
    rotate y*110
}

#declare rC=1.5;
#declare C_Liquid=color rgbf<rC*233/255,rC*165/255,rC*135/255,0.999>;
#declare eGlass=0.2;
#declare dotest=0;

object{
    MakeGlass(eGlass,C_Liquid,dotest)         
    translate -x*6
}
plane{y,0 texture{pigment{White}finish{ambient 0 diffuse 1}}}

//background{White}
*/