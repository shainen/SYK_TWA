(* ::Package:: *)

(* ::Section:: *)
(*All*)


(* ::Subsubsection:: *)
(*setup*)


(*SetDirectory[NotebookDirectory[]]*)


SetDirectory[Directory[]<>"/SYK_TWA"];


SetSystemOptions["ParallelOptions" -> "ParallelThreadNumber" -> 1];
SetSystemOptions["MKLThreads" -> 1];


<<randomSeed.wl


<<constants.wl


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


(*Jcoup[a_,b_,c_,d_]:=JcoupNums[[a,b,c,d]]*)


(*Tcoup[a_,b_]:=TcoupNums[[a,b]]*)


fermOc=0;
Table[
(*JcoupNums=getSYKCoups[sites];*)
pathsForward=singleRunShort[SYKEqs,randomInitsFermiHubbard,times];
(*TcoupNums=getHopCoups[sites];*)
pathsHop=singleRunShort[HopEqs,Flatten[randomInitsFHMid[0,Last@pathsForward]],midTimes];
(*JcoupNums=-JcoupNums;*)
pathsBackwards=singleRunShort[SYKEqs,Flatten[randomInitsFHMid[0,Last@pathsHop]],backTimes];
obsForward=Chop[obsfun/@pathsForward];
obsHop=Chop[obsfun/@pathsHop];
obsBackwards=Chop[obsfun/@pathsBackwards];
AddTo[fermOc,{obsForward,obsHop,obsBackwards}/runs];
,{rr,runs}];


mmu=MaxMemoryUsed[]/10.^6;


SetDirectory[ParentDirectory[]];


Save["dataFermion.dat",{mmu,fermOc}];
