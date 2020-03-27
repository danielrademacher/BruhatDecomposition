######################################
# BruhatDecompositionSU.gd
######################################





####################
# PART I - a)
#    Originally implemented subfunctions
####################

InfoBruhat := NewInfoClass("InfoBruhat");;
SetInfoLevel( InfoBruhat, 2 );

#####
# MakePermutationMat()
#####

# Given a permutation an integer d > 0 and a field fld, this function computes
# the permutation matrix P in M_{d x d}(fld).

# Input:
#    perm:    A permutation
#    dim:     A natural number
#    fld:     A field

# Output: res: The permutation matrix of perm over M_{d x d}(fld)
#                 (ie res_{i,j} = One(fld) if i^perm = j)

DeclareGlobalFunction( "MakePermutationMat" );



#####
# LGOStandardGensSU
#####

# This function computes the standard generators of SL
# as given by C. R. Leedham-Green and E. A. O'Brien in
# "Constructive Recognition of Classical Groups  in odd characteristic"

# Input:
#    d: the dimension of our matrix
#    q: A prime power q = p^f, where F_q ist the field whereover the matrices
#        are defined

# Output: stdgens the LGO standard-generators of SU(d,q)

DeclareGlobalFunction( "LGOStandardGensSU" );




#####
#   CoefficientsPrimitiveElementS
#####

# This function computes the standard generators of SL
# as given by C. R. Leedham-Green and E. A. O'Brien in
# "Constructive Recognition of Classical Groups  in odd characteristic"

# Input:
#    d: the dimension of our matrix
#    q: A prime power q = p^f, where F_q ist the field whereover the matrices
#        are defined

# Output: stdgens the LGO standard-generators of SU(d,q)

DeclareGlobalFunction( "CoefficientsPrimitiveElementS" );



#####
# UnitriangularDecompositionSUEven
#####

# This function computes the standard generators of SL
# as given by C. R. Leedham-Green and E. A. O'Brien in
# "Constructive Recognition of Classical Groups  in odd characteristic"

# Input:
#    d: the dimension of our matrix
#    q: A prime power q = p^f, where F_q ist the field whereover the matrices
#        are defined

# Output: stdgens the LGO standard-generators of SU(d,q)

DeclareGlobalFunction( "UnitriangularDecompositionSUEven" );



#####
# UnitriangularDecompositionSUOdd
#####

# This function computes the standard generators of SL
# as given by C. R. Leedham-Green and E. A. O'Brien in
# "Constructive Recognition of Classical Groups  in odd characteristic"

# Input:
#    d: the dimension of our matrix
#    q: A prime power q = p^f, where F_q ist the field whereover the matrices
#        are defined

# Output: stdgens the LGO standard-generators of SU(d,q)

DeclareGlobalFunction( "UnitriangularDecompositionSUOdd" );



#####
# UnitriangularDecompositionSU
#####

# This function computes the standard generators of SL
# as given by C. R. Leedham-Green and E. A. O'Brien in
# "Constructive Recognition of Classical Groups  in odd characteristic"

# Input:
#    d: the dimension of our matrix
#    q: A prime power q = p^f, where F_q ist the field whereover the matrices
#        are defined

# Output: stdgens the LGO standard-generators of SU(d,q)

DeclareGlobalFunction( "UnitriangularDecompositionSU" );



#####
#   BruhatDecompositionSU
#####

# This function computes the standard generators of SL
# as given by C. R. Leedham-Green and E. A. O'Brien in
# "Constructive Recognition of Classical Groups  in odd characteristic"

# Input:
#    d: the dimension of our matrix
#    q: A prime power q = p^f, where F_q ist the field whereover the matrices
#        are defined

# Output: stdgens the LGO standard-generators of SU(d,q)

DeclareGlobalFunction( "BruhatDecompositionSU" );



#####
#   MonomialSLPSUOdd
#####

# This function computes the standard generators of SL
# as given by C. R. Leedham-Green and E. A. O'Brien in
# "Constructive Recognition of Classical Groups  in odd characteristic"

# Input:
#    d: the dimension of our matrix
#    q: A prime power q = p^f, where F_q ist the field whereover the matrices
#        are defined

# Output: stdgens the LGO standard-generators of SU(d,q)

DeclareGlobalFunction( "MonomialSLPSUOdd" );



#####
#   MonomialSLPSUEven
#####

# This function computes the standard generators of SL
# as given by C. R. Leedham-Green and E. A. O'Brien in
# "Constructive Recognition of Classical Groups  in odd characteristic"

# Input:
#    d: the dimension of our matrix
#    q: A prime power q = p^f, where F_q ist the field whereover the matrices
#        are defined

# Output: stdgens the LGO standard-generators of SU(d,q)

DeclareGlobalFunction( "MonomialSLPSUEven" );



#####
#   CheckContinue
#####

# This function computes the standard generators of SL
# as given by C. R. Leedham-Green and E. A. O'Brien in
# "Constructive Recognition of Classical Groups  in odd characteristic"

# Input:
#    d: the dimension of our matrix
#    q: A prime power q = p^f, where F_q ist the field whereover the matrices
#        are defined

# Output: stdgens the LGO standard-generators of SU(d,q)

DeclareGlobalFunction( "CheckContinue" );



#####
#   CycleFromPermutation
#####

# This function computes the standard generators of SL
# as given by C. R. Leedham-Green and E. A. O'Brien in
# "Constructive Recognition of Classical Groups  in odd characteristic"

# Input:
#    d: the dimension of our matrix
#    q: A prime power q = p^f, where F_q ist the field whereover the matrices
#        are defined

# Output: stdgens the LGO standard-generators of SU(d,q)

DeclareGlobalFunction( "CycleFromPermutation" );



#####
#   CycleFromListMine
#####

# This function computes the standard generators of SL
# as given by C. R. Leedham-Green and E. A. O'Brien in
# "Constructive Recognition of Classical Groups  in odd characteristic"

# Input:
#    d: the dimension of our matrix
#    q: A prime power q = p^f, where F_q ist the field whereover the matrices
#        are defined

# Output: stdgens the LGO standard-generators of SU(d,q)

DeclareGlobalFunction( "CycleFromListMine" );



#####
#   DiagSLPSUOdd
#####

# This function computes the standard generators of SL
# as given by C. R. Leedham-Green and E. A. O'Brien in
# "Constructive Recognition of Classical Groups  in odd characteristic"

# Input:
#    d: the dimension of our matrix
#    q: A prime power q = p^f, where F_q ist the field whereover the matrices
#        are defined

# Output: stdgens the LGO standard-generators of SU(d,q)

DeclareGlobalFunction( "DiagSLPSUOdd" );




#####
#   DiagSLPSU
#####

# This function computes the standard generators of SL
# as given by C. R. Leedham-Green and E. A. O'Brien in
# "Constructive Recognition of Classical Groups  in odd characteristic"

# Input:
#    d: the dimension of our matrix
#    q: A prime power q = p^f, where F_q ist the field whereover the matrices
#        are defined

# Output: stdgens the LGO standard-generators of SU(d,q)

DeclareGlobalFunction( "DiagSLPSU" );




#####
#   DiagSLPSUEven
#####

# This function computes the standard generators of SL
# as given by C. R. Leedham-Green and E. A. O'Brien in
# "Constructive Recognition of Classical Groups  in odd characteristic"

# Input:
#    d: the dimension of our matrix
#    q: A prime power q = p^f, where F_q ist the field whereover the matrices
#        are defined

# Output: stdgens the LGO standard-generators of SU(d,q)

DeclareGlobalFunction( "DiagSLPSUEven" );

