use <libs/involute_gears.scad>;

/*
gear (
	number_of_teeth=15,     -> Numero de dientes
	circular_pitch=false,   -> 
    diametral_pitch=false,  -> 
	pressure_angle=28,      -> Angulo de presion
	clearance = 0.2,        -> 
	gear_thickness=5,       -> Grosor del Interior
	rim_thickness=8,        -> Grosor de los Dientes
	rim_width=5,            -> 
	hub_thickness=10,       -> Grosor Parte central
	hub_diameter=15,        -> Diametro Parte central
	bore_diameter=5,        -> Diametro de Taladro
	circles=0,              -> Numero de circulos en el Interior
	backlash=0,             -> Backlash permitido
	twist=0,                -> Angulo del Diente
	involute_facets=0,      -> 
	flat=false)             -> 
*/



relacionIn = 1;     //Relacion Entrada
relacionOut = 100;   //Relacion Salida
invFac = 10;        //Calidad del acabado
pressAng = 28;      //Angulo de presion
cirPitch = 250;     //Circular Pitch
holeIn = 5;         //Diametro taladro Entrada
holeOut = 5;        //Diametro taladro Salida
grosor = 5;         //Grosor Engranajes
//inDent = 30;      //Dientes Engranaje entrada
//angle=0;          //Punto de union
//ratioMaximo = 4;    
relaciones = 3;

ratio = (relacionOut>relacionIn) ? relacionOut/relacionIn : -relacionIn/relacionOut ;
vectRatios = [1, 2, 2];


//get_gears(relacionIn, relacionOut);

module get_gears (ratio) {
    
    for (i=vectRatios) {
    
        raTotal = raTotal*vectRatios;
        
    }
    
    echo ("Ratio Total: ", raTotal);
    
    
    //nuevoRatio = nuevo_ratio(ratio, 2);
    //ratioRestante = ratio_restante (ratio, 2);
    
    
    
}


function () = (  ) ?  :  ;

function ratio_restante (ratio, ratioDiv) = ( round(ratio/ratioDiv)-(ratio/ratioDiv) == 0 ) ? ratio/ratioDiv : ratio_restante (ratio, ratioDiv+1) ;

function nuevo_ratio (ratio, ratioDiv) = ( round(ratio/ratioDiv)-(ratio/ratioDiv) == 0 ) ? ratioDiv : nuevo_ratio (ratio, ratioDiv+1) ;




//////////////////////////////////////////////////
//
//         ---Modulo double_gear---
//
//         Crea un engranaje doble
//
//////////////////////////////////////////////////

//---Ejemplo
//
//double_gear();
//


module double_gear(
    infDent = 30,       //Dientes Engranaje Entrada
    supDent=10,         //Dientes Engranaje Salida
    invFac = 10,        //Calidad del acabado
    pressAng = 28,      //Angulo de presion
    cirPitch = 250,     //Circular Pitch
    drill = 5,          //Diametro taladro Salida
    grosorInf = 5,      //Grosor Engranaje Entrada
    grosorSup = 5,      //Grosor Enganaje Salida
    angleInf=0,         //Punto de union engranaje inferior
    angleSup=0          //Punto de union engranaje superior
    ) {
        
        //Definimos los vectores de los engranajes
        gearSetIn = [
            invFac,     //involute_facets
            drill,      //bore_diameter
            pressAng,   //pressure_angle
            cirPitch,   //circular_pitch
            grosorInf,  //gear_thickness
            grosorInf,  //rim_thickness
            grosorInf,  //hub_thickness
            0,          //circles
            0,          //twist
            infDent     //number_of_teeth
        ];
        gearSetOut = [
            invFac,     //involute_facets
            drill,      //bore_diameter
            pressAng,   //pressure_angle
            cirPitch,   //circular_pitch
            grosorSup,  //gear_thickness
            grosorSup,  //rim_thickness
            grosorSup,  //hub_thickness
            0,          //circles
            0,          //twist
            supDent     //number_of_teeth
        ];
        
        
        union() {
            //Creamos en engranaje inferior
            color("orange")
            gear_rotated(gearRotated=gearSetIn, alfa=angleInf, dent=1);
            
            //Creamos en engranaje superior
            color("purple")
            translate ([0,0,grosorInf]) {
                gear_rotated(gearRotated=gearSetOut, alfa=angleSup, dent=1);
            }
        }
        
}

//////////////////////////////////////////////////
//
//       ---Modulo simple gear_set---
//
//  Crea un juego de dos engranajes con la
//  relacion y el punto de union especificados
//
//////////////////////////////////////////////////

//---Ejemplo
//
//simple_gear_set(angle=0);
//

module simple_gear_set(
    relacion1=1,        //Relacion entrada
    relacion2=2,        //Relacion salida
    invFac = 10,        //Calidad del acabado
    pressAng = 28,      //Angulo de presion
    cirPitch = 250,     //Circular Pitch
    holeIn = 5,         //Diametro taladro Entrada
    holeOut = 5,        //Diametro taladro Salida
    grosor = 5,         //Grosor Engranajes
    inDent = 10,        //Dientes Engranaje entrada
    angle=0             //Punto de union
    ) {
        //Dientes engranaje salida
        outDent = (relacion2>relacion1) ? (inDent*(relacion2/relacion1)) : (inDent*(relacion2/relacion1));
        
        //Definimos los vectores de los engranajes
        gearSetIn = [
            invFac,     //involute_facets
            holeIn,     //bore_diameter
            pressAng,   //pressure_angle
            cirPitch,   //circular_pitch
            grosor,     //gear_thickness
            grosor,     //rim_thickness
            grosor,     //hub_thickness
            0,          //circles
            0,          //twist
            inDent      //number_of_teeth
        ];
        gearSetOut = [
            invFac,     //involute_facets
            holeIn,     //bore_diameter
            pressAng,   //pressure_angle
            cirPitch,   //circular_pitch
            grosor,     //gear_thickness
            grosor,     //rim_thickness
            grosor,     //hub_thickness
            0,          //circles
            0,          //twist
            outDent     //number_of_teeth
        ];
        
        
        //Coordenadas de la union de los engranajes
        h = gear_distance(inDent, outDent, cirPitch);
        x = (cos(angle))*h;
        y = (sin(angle))*h;
        
        //Creamos en engranaje de entrada
        color("orange")
        gear_rotated(gearRotated=gearSetIn, alfa=angle, dent=0);
        
        //Creamos en engranaje de salida
        color("purple")
        translate ([x,y,0]) {
            gear_rotated(gearRotated=gearSetOut, alfa=angle+180, dent=1);
        }
        
}

//
//Calcula la distancia entre dos engranajes
//
function gear_distance(z1, z2, cp) = (((z1*cp)/360)+((z2*cp)/360));

//
//Crea un engranaje con un diente o hueco orientado
//en la direccion especificada por el parametro alfa       
//


///////////////////////////////////////////////////////////////
//
//              ---Modulo gear_rotated---
//
//  Crea un engranaje con un diente o hueco orientado
//  en la direccion especificada por el parametro alfa
//
//////////////////////////////////////////////////////////////
module gear_rotated(
    gearRotated = [
    10,         //involute_facets
    5,          //bore_diameter
    28,         //pressure_angle
    250,        //circular_pitch
    5,          //gear_thickness
    5,          //rim_thickness
    5,          //hub_thickness
    0,          //circles
    0,          //twist
    10          //number_of_teeth
    ],
    alfa=0,     //Angulo del diente
    dent=1){    //1=Diente , 0=Hueco
        
        angDent = 360/gearRotated[9];
        
        var =   (dent == 0) ? (((round(alfa/angDent) - alfa/angDent)*angDent)+(angDent/2)) : ((round(alfa/angDent) - alfa/angDent)*angDent) ;
               
        rotate([0,0, -var]) {
            gear (
                involute_facets = gearRotated[0],
                bore_diameter = gearRotated[1],
                pressure_angle = gearRotated[2],
                circular_pitch = gearRotated[3],
                gear_thickness = gearRotated[4],
                rim_thickness = gearRotated[5],
                hub_thickness = gearRotated[6],
                circles = gearRotated[7],
                twist = gearRotated[8],
                number_of_teeth = gearRotated[9]
            );
        }
                
}