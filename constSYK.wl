(* ::Package:: *)

(*pathToStart="/projectnb/twambl/170524_2_startSYKs20_staticcoups/rundefined/start.dat";*)


(*pathToStart="/Users/shainen/Dropbox/Research/fTWA/SYK Echo/start.dat";*)


pathToJcoup="/projectnb/twambl/170525_1_s18f9_makemats/";


pathToTcoup="/projectnb/twambl/170527_1_s18f9_makeperts/";


tmax=0.06;
dt=0.0001;
times=N[Range[0,tmax-dt,dt]];


delT=0.002;
midTimes=N[Range[0,delT-dt,dt]];


extra=1/4;
backTimes=N[Range[0,-(1+extra)*tmax+dt,-dt]];


Length[backTimes]


runs=10;


length=18;


sites=length;


numferm=sites;


(*midPairs = Flatten[{Table[Table[{ii, jj}, {jj, ii, sites}], {ii, sites}]}, 2];
lowPairs = {};*)


midPairs = Flatten[{Table[Table[{ii, jj}, {jj, ii, sites}], {ii, sites}]}, 2];
lowPairs = Flatten[{Table[Table[{ii, jj}, {jj, ii+1, sites}], {ii, sites}]}, 2];


(*bonds=Table[{n,Mod[n+1,length,1]},{n,length-1}];*)


(*bonds=Flatten[Table[Table[{i,j},{j,i+1,sites}],{i,sites-1}],1]*)


(*alpha=1;*)


(*hopt[t_] := 1.*)


(*intU[t_] := 0.*)


(*occupied=Join[nfc/@(Position[fermenergy,_?Negative,2]-1),nfc/@(Position[fermenergy,0.,2]-1),nfc/@(Position[fermenergy,_?Negative,2]-1)+sites,nfc/@(Position[fermenergy,0.,2]-1)+sites];*)


occupied=Range[sites/2];


(*occupied={7,8,9,10};*)


sym1 = 0;
sym2 = 1;
sym3 = 0;
