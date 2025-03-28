#
# BruhatDecomposition: Computes the Bruhat Decomposition of matrices of the classical groups.
#
# Reading the declaration part of the package.
#

InfoBruhat := NewInfoClass("InfoBruhat");
SetInfoLevel( InfoBruhat, 2 );

ReadPackage("BruhatDecomposition", "gap/BruhatDecomposition.gd");
ReadPackage("BruhatDecomposition", "gap/BruhatDecompositionSL.gd");
ReadPackage("BruhatDecomposition", "gap/BruhatDecompositionSU.gd");
ReadPackage("BruhatDecomposition", "gap/BruhatDecompositionSp.gd");
ReadPackage("BruhatDecomposition", "gap/BruhatDecompositionO.gd");
