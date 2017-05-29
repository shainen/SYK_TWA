(* ::Package:: *)

singleRunShort=Function[{startEq,newInits,times},
Block[{newstate=First@NDSolve`Reinitialize[startEq,newInits],sol,values},
NDSolve`Iterate[newstate,Last[times]];
sol=NDSolve`ProcessSolutions[newstate][[All,2]];
values=Outer[#2[#1]&,times,sol]
]
];


randomInitsFermiHubbard:=Flatten[{Em[#1,#2][0]==randomEm[#1,#2]&@@@midPairs,El[#1,#2][0]==randomEl[#1,#2]&@@@lowPairs}]


meanInitsFermiHubbard:=Flatten[{Em[#1,#2][0]==meanEm[#1,#2]&@@@midPairs,El[#1,#2][0]==meanEl[#1,#2]&@@@lowPairs}]
