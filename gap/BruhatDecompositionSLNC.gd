######################################
# MyBruhatDecompositionNC.gd
######################################

######################################
#
#    NC Version:
#    This is a NC version of the Bruhat Decomposition
#    In all implemented functions are all used functions replaced through
#    their NC version (if one exists). Moreover are all checks from functions
#    of BruhatDecomposition have been removed
#
#    This functions has been modified by this actions and got a NC Version:
#        MakeSLP -> MakeSLPNC (uses the NC version of StraightLineProgram)
#        MyPermutationMat -> MyPermutationMatNC (uses ConvertToMatrixRepNC)
#        LGOStandardGens -> LGOStandardGensNC (uses MyPermutationMatNC)
#    The NC versions of the following functions do not check for user input
#        MatToWreathProd -> MatToWreathProdNC
#        TestIfMonomial -> TestIfMonomialNC
#        UnipotentDecomposition -> UnipotentDecompositionNC
#        UnipotentDecompositionWithTi -> UnipotentDecompositionWithTiNC
#        PermutationMonomialMatrix -> PermutationMonomialMatrixNC
#        PermSLP -> PermSLPNC (also uses other NC versions of other functions)
#        DiagonalDecomposition -> DiagonalDecompositionNC
#    BruhatDecompositionNC and BruhatDecompositionWithTiNC now use the NC
#    versions of UnipotentDecomposition, PermSLP and DiagonalDecomposition
#        BruhatDecomposition -> BruhatDecompositionNC
#        BruhatDecompositionWithTi -> BruhatDecompositionWithTiNC
#
######################################

####################
# PART I - a)
#    Originally implemented subfunctions
####################

InfoBruhat := NewInfoClass("InfoBruhat");;
SetInfoLevel( InfoBruhat, 2 );

#####
# MakeSLPNC()
#####

# To increase readability, the lists slp as defined later
# (see Unipotent-, Diagonal-, BruhatDecomposition and PermSLP)
# start with [1,1],[2,1],.. [5,1]. However this represents the LGO standard-
# generators and is the input of our straight-line program.
# Defining and SLP we thus have to exclude this instructions from our list.

# Input:    slp: A list of instructions for a straight-line program
#            genlen: The number of inputs for our SLP
#                        (ie the number of generators )

# Output: An SLP using the instructions of slp and genlen inputs

DeclareGlobalFunction( "MakeSLPNC" );



#####
# MyPermutationMatNC()
#####

# Given a permutation an integer d > 0 and a field fld, this function computes
# the permutation matrix P in M_{d x d}(fld).

# Input:
#    perm:    A permutation
#    dim:     A natural number
#    fld:     A field

# Output: res: The permutation matrix of perm over M_{d x d}(fld)
#                 (ie res_{i,j} = One(fld) if i^perm = j)

DeclareGlobalFunction( "MyPermutationMatNC" );



#####
# LGOStandardGensNC()
#####

# This function computes the standard generators of SL(d,q)
# as given by C. R. Leedham-Green and E. A. O'Brien in:
# "Constructive Recognition of Classical Groups  in odd characteristic"
# (This matrices can also be found in the paper ch 3.1 ps 6-7)

# Input:
#    d: the dimension of our matrix
#    q: A prime power q = p^f, where F_q ist the field whereover the matrices
#        are defined

# Output: stdgens the LGO standard-generators of SL(d,q)

DeclareGlobalFunction( "LGOStandardGensNC" );



#####
# MatToWreathProdNC()
#####

DeclareGlobalFunction( "MatToWreathProdNC" );



#####
# TestIfMonomialNC()
#####

# Tests if a given matrix M is monomial matrix
# there is function in GAP, however it does not seem to work for SL(d,q).

# Input: M: A Matrix

# Output: true if M is Monomial, false else

DeclareGlobalFunction( "TestIfMonomialNC" );



#####
# UnipotentDecompositionNC()
#####
# Computes the Unitriangular decomposition of the matrix g

# Input:
#    stdgens: The LGO standard-generators
#    g:    a matrix in SL(d,q)

# Output: slp: A list of instructions yielding u1,u2 if evaluated as SLP
#        [u1,g,u2]: The matrices of Bruhat-Decomposition

DeclareGlobalFunction( "UnipotentDecompositionNC" );



#####
# UnipotentDecompositionWithTiNC()
#####

# Compute the Bruhat decomposition of the matrix g, given
# the standard generators for the group.
# In this version we will store all the transvections t_i,i-1(w^l).
# this will increase the memory usage by (d-3)*f but reduce runtime

# Input:
#    stdgens: The LGO standard-generators
#    g:    a matrix in SL(d,q)

# Output: slp: A list of instructions yielding u1,u2 and all transvections
#                    if evaluated as SLP
#        [u1,g,u2]: The matrices of Bruhat-Decomposition

DeclareGlobalFunction( "UnipotentDecompositionWithTiNC" );



#####
# PermutationMonomialMatrixNC()
#####
# Find the permutation (in Sym(d) corresponding to a monomial matrix

# Input:    M: A monomial matrix

# Output:    diag: The vector of non-zero entries, where diag[i] is the non-zero
#                entry of row i.
#            perm: The  permutation associated to M
#                     (ie i^perm = j if M_i,j not 0)

DeclareGlobalFunction( "PermutationMonomialMatrixNC" );



#####
# PermSLPNC()
#####

# In this function we will transform a monomial matrix w in SL(d,q) into
# a diagonal matrix diag. Using only the standard-generators s,v,x this
# will lead to a signed permutation matrix
# (ie a monomial matrix p_sign with only +-1 in non-zero entries )
# and p_sign*diag = w (ie diag = p_sign^-1*w )
# Furthermore we will return list slp of instructions which will
# (when evaluated at the LGO standard-generators) yield diag.

# If the permutation pi_w associated with w (ie i^\pi_w = j if w_i,j not 0)
# is the inverse of the permutation pi_{p_sign} associated to p_sign
# (both pi_w and pi_{p_sign} are permutations in Sym(d)),
# then p_sign^-1 * w is a diagonal matrix.

# In PermSLP() we thus transform \pi_w to () using only { \pi_s, \pi_v, \pi_x }
# In order to know diag without computing all matrix multiplications,
# (we don't know the signs of p_sign), we compute a second permutation
# simultaneously. Here we use the identification with permutations in Sym(2d)
# (see MatToWreathProd() and WreathProdToMat() ) and unique identifications
# between { \pi_s, \pi_v, \pi_x } and {s,v,x}.

# Input:    stdgens:  The LGO standard-generators
#            mat:    A monomial matrix  (ie w)
#            slp:    An already existing list of instructions *optional

# Output:    slp: A list of instructions to evaluate p_sign
#                (if slp was Input then this instructions are added to slp)
#            p_sign: The signed permutation matrix
#            mat: the diagonal matrix diag

DeclareGlobalFunction( "PermSLPNC" );



#####
# DiagonalDecompositionNC()
#####

# Writes a list of instructions which evaluated on LGO standard-generators
# yield the diagonal matrix of the input.

# Input:    stdgens:    The LGO standard-generators
#            diag:        A diagonal matrix  (eg diag)
#            slp:    An already existing list of instructions *optional

# Output:    slp: A list of instructions to evaluate diag
#                (if slp was Input then this instructions are added to slp)
#            hres: The the identity matrix

DeclareGlobalFunction( "DiagonalDecompositionNC" );



#####
# BruhatDecompositionNC()
#####

# Uses UnipotentDecomposition(), PermSLP() and DiagonalDecomposition()
# to write a matrix g \in SL(d,q) as g = u1^-1*p_sign*diag*u2^-2
# where u1,u2 are lower unitriangular matrices, p_sign a monomial matrix
# with only +1 and -1 as non-zero entries and diag a diagonal matrix.
# It furthermore yields an SLP that reurns the above matrices if evaluated
# at the LGO standard-generators.

# Input: stdgens: The LGO standard-generators
#        g:    A matrix in SL(d,q)

# Output: pgr: A SLP to compute u1,u2,p_sign and diag
#        and the matrices u1, u2, p_sign and diag itself

DeclareGlobalFunction( "BruhatDecompositionNC" );


#####
# BruhatDecompositionWithTiNC()
#####

# As BruhatDecomposition() but replace UnipotentDecomposition()
# by UnipotentDecompositionWithTi.

# Input: stdgens: The LGO standard-generators
#        g:    A matrix in SL(d,q)

# Output: pgr: A SLP to compute u1,u2,p_sign, diag
#                and all transvections t_{i,i-1}(omega^ell)
#            the matrices u1, u2, p_sign and diag itself

DeclareGlobalFunction( "BruhatDecompositionWithTiNC" );
