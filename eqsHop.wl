(* ::Package:: *)

getHopCoups=Function[{sites},
rands=RandomVariate[NormalDistribution[0,1],{sites,sites}];
rands
];
makeDSolveStartHop=Function[{observables},
Tcoup=getHopCoups[sites];
Block[{
hamHop=Total[(Tcoup[[#1,#2]]
(hEm[#1,#2]+hEm[#2,#1])
)&@@@midPairs],
eqnsEm,eqnsEl,initsEm,initsEl,start
},
eqnsEm=Em[#1,#2]'[t]==hamHop[[2,1,#1,#2]]&@@@midPairs;
eqnsEl=El[#1,#2]'[t]==hamHop[[2,2,#1,#2]]&@@@lowPairs;
initsEm=Em[#1,#2][0]==0&@@@midPairs;
initsEl=El[#1,#2][0]==0&@@@lowPairs;
start=First@NDSolve`ProcessEquations[Flatten[{eqnsEm,eqnsEl,initsEm,initsEl}],observables,t,Method->{"EquationSimplification"->"Solve"}];
start
]
];
