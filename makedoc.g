#
# BruhatDecomposition: Computes the Bruhat Decomposition of matrices of the classical groups.
#
# This file is a script which compiles the package manual.
#
if fail = LoadPackage("AutoDoc", "2018.02.14") then
    Error("AutoDoc version 2018.02.14 or newer is required.");
fi;

AutoDoc( );
