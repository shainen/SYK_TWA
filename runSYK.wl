(* ::Package:: *)

(* ::Section:: *)
(*All*)


(* ::Subsubsection:: *)
(*setup*)


(*SetDirectory[NotebookDirectory[]]*)


SetDirectory[Directory[]<>"/fermionTWA"];


SetSystemOptions["ParallelOptions" -> "ParallelThreadNumber" -> 1];
SetSystemOptions["MKLThreads" -> 1];


<<randomSeed.wl


<<dynComplex.wl


<<constSYK.wl


<<initsComplex.wl


<<ndsolve.wl


(* ::Subsection:: *)
(*run TWA*)


obsfun=Function[{values},
values[[1,Position[midPairs,{#,#}][[1,1]]]]+1/2&/@Range[numferm]
];


Get[pathToStart];


Jcoup[a_,b_,c_,d_]:=JcoupNums[[a,b,c,d]]


Tcoup[a_,b_]:=TcoupNums[[a,b]]


getSYKCoups=Function[{sites},
randsR=RandomVariate[NormalDistribution[0,1],{sites,sites,sites,sites}];
randsI=RandomVariate[NormalDistribution[0,1],{sites,sites,sites,sites}];
randComp=randsR+I*randsI;
randAntiSym=randComp+Conjugate[Transpose[randComp,{4,3,2,1}]];
randNorm=randAntiSym/2/sites^2;
randNorm
];


getHopCoups=Function[{sites},
rands=RandomVariate[NormalDistribution[0,1],{sites,sites}]/sites;
rands
];


fermOc=0;
Table[
JcoupNums=getSYKCoups[sites];
pathsForward=singleRunShort[SYKEqs,randomInitsFermiHubbard,times];
TcoupNums=getHopCoup[sites];
pathsHop=singleRunShort[HopEqs,Flatten[randomInitsFHMid[0,Last@pathsForward]],{delT}];
JcoupNums=-JcoupNums;
pathsBackwards=singleRunShort[SYKEqs,Flatten[randomInitsFHMid[0,Last@pathsHop]],times];
obsForward=Chop[obsfun/@pathsForward];
obsBackwards=Chop[obsfun/@pathsBackwards];
AddTo[fermOc,{obsForward,obsBackwards}/runs];
,{rr,runs}];


mmu=MaxMemoryUsed[]/10.^6;


SetDirectory[ParentDirectory[]];


Save["dataFermion.dat",{mmu,fermOc}];
