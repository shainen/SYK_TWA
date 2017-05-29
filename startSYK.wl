(* ::Package:: *)

(* ::Section:: *)
(*All*)


(* ::Subsubsection:: *)
(*setup*)


(*SetDirectory[NotebookDirectory[]]*)


SetDirectory[Directory[]<>"/SYK_TWA"];


<<dynComplex.wl


<<constSYK.wl


<<eqsSYKboth.wl


<<eqsHop.wl


<<initsComplex.wl


<<ndsolve.wl


(* ::Subsection:: *)
(*run TWA*)


Dynamic[rr]


(*observables={Em[#,#]&/@Range[numferm],bh[#]&/@Range[numbos]
(*,Flatten[{Table[Table[Em[ii,jj],{jj,ii+1,numferm}],{ii,numferm-1}],Table[Table[El[ii,jj],{jj,ii+1,numferm}],{ii,numferm-1}]}]*)
};
obsfun=Function[{values},
{values[[1]]+1/2,Abs[values[[2]]]^2-1/2,
(*Total[(values[[1]]\[Transpose])^2]/2+Total[Abs[values[[3]]\[Transpose]]^2]*)
values[[2]]
}
];*)


observables={Em[#1,#2]&@@@midPairs,El[#1,#2]&@@@lowPairs
(*Em[#,#]&/@Range[numferm]*)
(*,Flatten[{Em[#1,#2]&@@@midPairs,El[#1,#2]&@@@lowPairs}]*)
};


real=Import[pathToJcoup<>"flatJreal.CSV","Data"];
imag=Import[pathToJcoup<>"flatJimag.CSV","Data"];
complex=real+I*imag;
Jcoup=ArrayReshape[complex,{sites,sites,sites,sites}];


coup=Import[pathToTcoup<>"flatTcoup.CSV","Data"];
Tcoup=ArrayReshape[coup,{sites,sites}];


Timing[SYKEqs=makeDSolveStartSYK[observables];]


Timing[HopEqs=makeDSolveStartHop[observables];]


mmu=MaxMemoryUsed[]/10.^6;


SetDirectory[ParentDirectory[]];


Save["start.dat",{mmu,SYKEqs,HopEqs}];
