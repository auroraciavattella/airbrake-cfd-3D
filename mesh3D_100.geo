SetFactory("OpenCASCADE"); // serve per usare BooleanDifference

// INPUT E DIMENSIONI DEI DOMINI
L_rocket = 3.375;

length_inner = 2.0*L_rocket;
height_inner = 2.0;

length_bound = 10.0*L_rocket;
height_bound = 5.0*L_rocket;

nc_inner = 120;
nc_bound = 4;

size_inner = length_inner / nc_inner;
size_bound = length_bound / nc_bound;


// PARAMETRI DELLA MESH
size_axis = size_inner;
size_wall = 0.008;
size_airbrake = 0.004;
size_far = 1.0;


// PARAMETRI GEOMETRICI
r_base = 0.045;       // raggio della parte terminale della coda
H_airbrake = 0.05;    // altezza radiale della paletta: 5 cm

xPaletta = 2.130;     // posizione assiale della paletta
tPaletta = 0.010;     // spessore assiale della paletta: 1 cm

rInner = 0.075;       // raggio del corpo del razzo
rOuter = rInner + H_airbrake;

widthOuter = 0.080;   // larghezza esterna totale: 8 cm
zOuter = widthOuter/2.0;

thetaPaletta = Asin(zOuter/rOuter);

yOuter = rOuter*Cos(thetaPaletta);
yInner = rInner*Cos(thetaPaletta);
zInner = rInner*Sin(thetaPaletta);


// PUNTI
Point(1) = {-16.93000, 0.00000, 0, size_axis};
Point(2) = {-0.05500, 16.87500, 0, size_far};

Point(5) = {-0.05500, 0.00000, 0, size_axis};
Point(6) = {-0.05500, 0.00300, 0, size_wall};

Point(7) = {0.16000, 0.04100, 0, size_wall};
Point(8) = {0.33000, 0.06200, 0, size_wall};
Point(9) = {0.60000, rInner, 0, size_wall};

Point(18) = {2.99000, rInner, 0, size_wall};

Point(19) = {3.07000, 0.07300, 0, size_wall};
Point(20) = {3.18000, 0.06300, 0, size_wall};

Point(21) = {3.32000, 0.00000, 0, size_axis};
Point(22) = {3.32000, r_base, 0, size_wall};

Point(25) = {37.07000, 0.00000, 0, size_axis};
Point(28) = {37.07000, 16.87500, 0, size_far};

Point(29) = {-2.05500, 0, 0, size_axis};
Point(30) = {-0.05500, 2.00000, 0, size_far};
Point(31) = {10.07000, 2.00000, 0, size_far};
Point(32) = {10.07000, 0, 0, size_axis};

Point(33) = {0.00000, 0.01600, 0, size_wall};
Point(34) = {0.07000, 0.02800, 0, size_wall};

Point(35) = {3.23500, 0.05650, 0, size_wall};
Point(36) = {3.27500, 0.05200, 0, size_wall};
Point(37) = {3.30000, 0.04850, 0, size_wall};


// PUNTI DELLA PALETTA
Point(500) = {xPaletta, 0, 0, size_airbrake};

Point(501) = {xPaletta, yInner, -zInner, size_airbrake};
Point(502) = {xPaletta, yOuter, -zOuter, size_airbrake};
Point(503) = {xPaletta, yOuter,  zOuter, size_airbrake};
Point(504) = {xPaletta, yInner,  zInner, size_airbrake};


// LINEE DEL DOMINIO ESTERNO
Circle(100) = {1, 5, 2};
Line(101) = {2, 28};
Line(102) = {28, 25};

Line(103) = {25, 32};
Line(104) = {32, 21};
Line(118) = {5, 29};
Line(119) = {29, 1};


// PROFILO DEL RAZZO
Line(105) = {5, 6};
Spline(106) = {6, 33, 34, 7, 8, 9};

Line(107) = {9, 18};

Spline(112) = {18, 19, 20, 35, 36, 37, 22};
Line(113) = {22, 21};


// LINEE DELLA PALETTA
Line(501) = {501, 502};
Circle(502) = {502, 500, 503};
Line(503) = {503, 504};
Circle(504) = {504, 500, 501};


// LINEE DEL DOMINIO INTERNO
Circle(114) = {29, 5, 30};
Line(115) = {30, 31};
Line(116) = {31, 32};


// CURVE LOOP
Curve Loop(200) = {118, 114, 115, 116, 104, -113, -112, -107, -106, -105};

Curve Loop(201) = {100, 101, 102, 103, -116, -115, -114, 119};

Curve Loop(505) = {501, 502, 503, 504};


// SUPERFICI 2D
Plane Surface(300) = {200};
Plane Surface(301) = {201};

Plane Surface(506) = {505};


// CHARACTERISTIC LENGTH
Characteristic Length {1, 2, 25, 28} = 1.0;

Characteristic Length {29, 30, 31, 32} = 0.06;

Characteristic Length {5, 21} = 0.02;

Characteristic Length {6, 7, 8, 9, 18, 19, 20, 22, 33, 34, 35, 36, 37} = 0.002;


// ALGORITMO MESH 2D
Mesh.Algorithm = 6;


// DIVISIONI SULLA PARETE DEL RAZZO
Transfinite Curve {106} = 100;
Transfinite Curve {107} = 1450;
Transfinite Curve {112} = 90;
Transfinite Curve {113} = 32;


// DIVISIONI SULLA PALETTA
Transfinite Curve {501, 503} = 14;
Transfinite Curve {502, 504} = 24;


// DIVISIONI DEL DOMINIO INTERNO
Transfinite Curve {114} = 100;
Transfinite Curve {115} = 180;
Transfinite Curve {116} = 100;
Transfinite Curve {118} = 110;

Transfinite Curve {104} = 500 Using Progression 0.99;


// DIVISIONI DEL DOMINIO ESTERNO
Transfinite Curve {100} = 14;
Transfinite Curve {101} = 12;
Transfinite Curve {102} = 8;
Transfinite Curve {103} = 70;
Transfinite Curve {119} = 50;


// CONTROLLO PROPAGAZIONE MESH
Mesh.MeshSizeExtendFromBoundary = 1;
Mesh.MeshSizeFromCurvature = 0;


// RAFFINAMENTO GENERALE DEL DOMINIO INTERNO
Field[20] = Box;

Field[20].VIn = 0.06;
Field[20].VOut = 10.0;

Field[20].XMin = -2.055;
Field[20].XMax = 10.070;

Field[20].YMin = 0.0;
Field[20].YMax = 2.0;

Field[20].Thickness = 6.0;

// INFITTIMENTO LOCALE SUL RACCORDO DELLA PALETTA (celle di superficie piccole)
Field[21] = Box;
Field[21].VIn = 0.0003;
Field[21].VOut = 10.0;
Field[21].XMin = 2.128;
Field[21].XMax = 2.142;
Field[21].YMin = yOuter - 0.002;
Field[21].YMax = rOuter + 0.001;
Field[21].ZMin = -0.050;
Field[21].ZMax = 0.050;
Field[21].Thickness = 0.004;

Field[22] = Min;
Field[22].FieldsList = {20, 21};

Background Field = 22;


// CREAZIONE DEL SETTORE DI 120Â°
Rotate {{1, 0, 0}, {0, 0, 0}, -60*Pi/180}
{
    Surface{300, 301};
}

out[] = Extrude {{1, 0, 0}, {0, 0, 0}, 120*Pi/180}
{
    Surface{300, 301};
};


// VOLUMI DEL SETTORE FLUIDO
wedgeVolumes[] = Volume{:};


// CREAZIONE DEL VOLUME DELLA PALETTA
paletta3D[] = Extrude {tPaletta, 0, 0}
{
    Surface{506};
};


// RACCORDO SUGLI SPIGOLI ESTERNI DELLA PALETTA
// curve 502 e 545: i due archi a r = 0.125 (bordo esterno) sulle facce x = 2.13 e x = 2.14.
// Come nel caso 2D: raccordo solo sugli spigoli esterni.
rFillet = 0.0007;
paletta3Dfillet[] = Fillet{paletta3D[1]}{502, 545}{rFillet};


// SOTTRAZIONE DELLA PALETTA DAL FLUIDO
fluidVolumes[] = BooleanDifference
{
    Volume{wedgeVolumes[]};
    Delete;
}
{
    Volume{paletta3Dfillet[]};
    Delete;
};

// Confine complessivo dei volumi fluidi dopo la sottrazione.
// Esclude le interfacce condivise fra i volumi.
boundaryFluid[] = CombinedBoundary
{
    Volume{fluidVolumes[]};
};

// Physical Surface("fluidBoundaryCheck") = {boundaryFluid[]};

Mesh.SaveAll = 0;


// GRUPPI FISICI
Physical Surface("inlet", 565) = {516};

Physical Surface("outlet", 566) = {518};

Physical Surface("top", 567) = {517};

Physical Surface("front", 568) = {519, 529};

Physical Surface("back", 569) = {301, 528};

// dopo il raccordo la numerazione delle superfici cambia:
// paletta = 520, 521, 522, 524, 525, 526, 527 (522 e 526 sono i raccordi)
// razzo   = 530, 531, 532, 533, 534
Physical Surface("rocketAirbrake", 570) = {530, 531, 532, 533, 534, 520, 521, 522, 524, 525, 526, 527};


// FORMATO COMPATIBILE CON OPENFOAM
Mesh.MshFileVersion = 2.2;
Mesh.Binary = 0;
Mesh.SaveAll = 0;
Mesh.SaveParametric = 0;

