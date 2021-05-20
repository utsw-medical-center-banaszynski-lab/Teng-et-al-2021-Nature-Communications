
G4 motif was predicted by modifying the Quadparser available at: 
https://github.com/dariober/bioinformatics-cafe/tree/master/fastaRegexFinder

G4 motif is defined as: ‘([gG]{3,}\w{1,12}){3,}[gG]{3,}’. 
The regex looks for 3 or more runs of guanines followed by 1 to 12 of any other bases. 
This is repeated 3 or more times, ending with 3 runs of guanines.
