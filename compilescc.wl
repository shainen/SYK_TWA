(* ::Package:: *)

dir=StringSplit[ParentDirectory[],"/"][[4]];
list=Range[21,30];
tempAll=0;
Do[
Get["/projectnb/twambl/"<>dir<>"/r"<>ToString[kk]<>"/dataFermion.dat"];
AddTo[tempAll,fermOc];
,{kk,list}];
fermOc=tempAll/Length[list];
Save["/projectnb/twambl/"<>dir<>"compiled.dat",fermOc];
