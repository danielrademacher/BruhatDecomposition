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
#   LGOStandardGensSp
#####

# This function computes the standard generators of SL
# as given by C. R. Leedham-Green and E. A. O'Brien in
# "Constructive Recognition of Classical Groups  in odd characteristic"

# Input:
#    d: the dimension of our matrix
#    q: A prime power q = p^f, where F_q ist the field whereover the matrices
#        are defined

# Output: stdgens the LGO standard-generators of Sp(d,q)

DeclareGlobalFunction( "LGOStandardGensSp" );



#####
#   UnitriangularDecompositionSp
#####

# This function computes the standard generators of SL
# as given by C. R. Leedham-Green and E. A. O'Brien in
# "Constructive Recognition of Classical Groups  in odd characteristic"

# Input:
#    d: the dimension of our matrix
#    q: A prime power q = p^f, where F_q ist the field whereover the matrices
#        are defined

# Output: stdgens the LGO standard-generators of SU(d,q)

DeclareGlobalFunction( "UnitriangularDecompositionSp" );




#####
#   MonomialSLPSp
#####

# This function computes the standard generators of SL
# as given by C. R. Leedham-Green and E. A. O'Brien in
# "Constructive Recognition of Classical Groups  in odd characteristic"

# Input:
#    d: the dimension of our matrix
#    q: A prime power q = p^f, where F_q ist the field whereover the matrices
#        are defined

# Output: stdgens the LGO standard-generators of SU(d,q)

DeclareGlobalFunction( "MonomialSLPSp" );




#####
#   DiagSLPSp
#####

# This function computes the standard generators of SL
# as given by C. R. Leedham-Green and E. A. O'Brien in
# "Constructive Recognition of Classical Groups  in odd characteristic"

# Input:
#    d: the dimension of our matrix
#    q: A prime power q = p^f, where F_q ist the field whereover the matrices
#        are defined

# Output: stdgens the LGO standard-generators of SU(d,q)

DeclareGlobalFunction( "DiagSLPSp" );





#####
#   BruhatDecompositionSp
#####

# This function computes the standard generators of SL
# as given by C. R. Leedham-Green and E. A. O'Brien in
# "Constructive Recognition of Classical Groups  in odd characteristic"

# Input:
#    d: the dimension of our matrix
#    q: A prime power q = p^f, where F_q ist the field whereover the matrices
#        are defined

# Output: stdgens the LGO standard-generators of SU(d,q)

DeclareGlobalFunction( "BruhatDecompositionSp" );


