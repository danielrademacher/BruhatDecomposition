######################################
# MyBruhatDecomposition.gd
######################################
#
#
#
######################################
# Concept:
#    This implementation follows the ideas of
#    "Straight-line programs with memory and matrix Bruhat decomposition"
#    by Alice Niemeyer, Tomasz Popiel & Cheryl Praeger.
#    In the following all references will mean this paper
#    and in case we differ from this paper (due to readability or bug-fixing)
#    this will also be remarked.
#
#    Let g \in SL(d,p^f)
#    Bruhat Decomposition computes g = u1 * w * u2, where
#         - u1,u2 are lower triangular matrices
#         - w is monomial matrix
#
#    In this algorithm we want to compute the Bruhat-Decomposition of g
#    and give g (respectively u1,w and u2) as word in the so called
#    "LGO standard generators" (Section 3.1).
#
#    1) While computing u1 (resp u2) with some kind of Gauß-Algorithm,
#    we express the matrices as product of so called transvections
#    - For 1 <= j < i <= d: t_{i,j}(\alpha) is the matrix T with
#        1-entries on diagonal, T_i,j = \alpha, 0 elsewhere
#    Each t_{i,j}(\alpha) can be computed from t_{2,1}(\alpha) via recursion,
#    where we have to distinguish the odd and even dimensons (p12 Lemma 4.2).
#    This again can be expressed as a product of t_{2,1}(omega^\ell)
#    (where omega is a primitive element and 0 <= ell < f).
#    The transvections as words in the standard generators are described in
#    (p12 Lemma 4.2).
#    This yields a decomposition of u1 and u2 in standard generators.
#
#    2) In a further step we will decompose the monomial Matrix w in
#    a signed permutation matrix p_sign and a diagonal Matrix diag.
#    ( How to associate p_sign with a product of generators is
#    further described in (PART I b) and (PART III) )
#
#    3) The last step is the decomposition of the diagonal Matrix in 2)
#    as word in the standard generators.
#
#    We won't do this matrix multiplications directly, but write them
#    in a list to evaluate in a StraightLineProgram. (Section 2)
#    Although described differently in the paper, we sometimes will allow
#    instructions to multiply more than two elements (eg during conjugating).
#    This doesn't affect the optimality of an slp much, but higly increases
#    the readability of our implementation.
######################################



####################
# PART I - a)
#    Originally implemented subfunctions
####################

InfoBruhat := NewInfoClass("InfoBruhat");;
SetInfoLevel( InfoBruhat, 2 );
#####
# MakeSLP()
#####

# To increase readability, the lists slp as defined later
# (see Unipotent-, Diagonal-, BruhatDecomposition and PermSLP)
# start with [1,1],[2,1],.. [5,1]. However this represents the LGO standard-
# generators and is the input of our straight-line program.
# Defining and SLP we thus have to exclude this instructions from our list.

# Input: slp: A list of instructions for a straight-line program
#            genlen: The number of inputs for our SLP
#                        (ie the number of generators )

# Output: An SLP using the instructions of slp and genlen inputs

#! @Description
#!   Insert documentation for your function here
DeclareGlobalFunction( "MakeSLP" );



#####
# CoefficientsPrimitiveElement()
#####

# The following function has been written by Thomas Breuer.
# It expresses an element alpha in a field fld as
# a linear combination of a Primitive Element.

# Input: fld: A field,
#        alpha : An element of fld

# Output: Coefficients: A vector c sth for omega primitive element
#            alpha = sum c[i] omega^(i-1)

DeclareGlobalFunction( "CoefficientsPrimitiveElement" );



#####
# MyPermutationMat()
#####

# Given a permutation an integer d > 0 and a field fld, this function computes
# the permutation matrix P in M_{d x d}(fld).

# Input:
#    perm:    A permutation
#    dim:     A natural number
#    fld:     A field

# Output: res: The permutation matrix of perm over M_{d x d}(fld)
#                 (ie res_{i,j} = One(fld) if i^perm = j)

DeclareGlobalFunction( "MyPermutationMat" );



#####
# LGOStandardGens
#####

# This function computes the standard generators of SL
# as given by C. R. Leedham-Green and E. A. O'Brien in
# "Constructive Recognition of Classical Groups  in odd characteristic"
# (This matrices can also be found in the paper ch 3.1 ps 6-7)

# Input:
#    d: the dimension of our matrix
#    q: A prime power q = p^f, where F_q ist the field whereover the matrices
#        are defined

# Output: stdgens the LGO standard-generators of SL(d,q)

DeclareGlobalFunction( "LGOStandardGens" );



####################
# PART I - b)
#    Additionally implemented subfunctions
####################

#####
# HighestSlotOfSLP()
#####

# We can't use Length(slp) as done in the original code to determine which
# slots are already used, because not every entry of slp creates a new slot
# while others may increase the highest slot used by more than one.
# (After explicitly writing in a slot j>N, the SLP continues creating slots
#    j+1,j+2,.. if no slot is explicitly given.)

# The following function determines the highest slot a SLP
# constructed from the list slp will write in.

# Input: slp: A list of instructions satisfying the properties for an SLP

# Output: highestslot: The number of slots this SLP will need if evaluated

DeclareGlobalFunction( "HighestSlotOfSLP" );



#####
# MatToWreathProd() and WreathProdToMat()
#####

# In PermSLP we want to transform the monomial matrix w given by
# UnipotentDecomposition() into a diagonal matrix.
#    (The exact procedure is described in PermSLP)
# Since multiplying the LGO standard-generators s,v and x not only involves
# permutations but we also have to consider which non-zero entries are +1 and
# which -1, we want to associate this matrices with permutations on 2d points.
# (cf Wreath-Product)

# < s,v,x > -> Sym(2d), M -> Mwr where
# i^Mwr =  j  and (i+d)^Mwr= j+d if M_i,j = 1        and
# i^Mwr = j+d and (i+d)^Mwr=  j  if M_i,j = -1
# for 1<=i<=d

# Due to their relation to wreath-products, we will call denote the image
# of a matrix M \in < s,v,x > by Mwr

# Input: M: A monomial matrix with only +1 and -1 entries

# Output: perm: the permutation Mwr

DeclareGlobalFunction( "MatToWreathProd" );



# In fact the association above is an isomorphism and we can associate to each
# permutation we compute during PermSLP a unique monomial matrix whose non-zero
# entries are +1 or -1.

# M_i,j = 1  if i^Mwr =  j <= d        and
# M_i,j = -1 if i^Mwr = j+d

# Input:    perm: A permutation in Sym(2d) sth. {{i,i+d}}_1<=i<=d are blocks
#            dim: The dimension of the matrix we want perm send to
#            fld: The field whereover the matrix is defined.

# Output:    res: The Matrix M satisfying the above properties

DeclareGlobalFunction( "WreathProdToMat" );



#####
# AEM (Ancient Egytian Multiplication)
#####

# At several occasions we will need to compute a high power of some value
# saved in a memory slot. For this purpose there is a variaton of AEM
# implemented below.

# Input:     spos: The memory slot, where a value b is saved in
#             respos:    The memory slot we want the exponentation to be written in
#            tmppos: A memory slot for temporary results
#            k:        An integer.

# Output:    instr: Lines of an SLP that will (when evaluated) take the value b
#            saved in spos and write b^k in respos

# Remarks:     tmpos and respos must differ.
#            If spos = respos or spos =  tmpos it will be overwritten.

DeclareGlobalFunction( "AEM" );



#####
# TestIfMonomial()
#####

# Tests if a given matrix M is monomial matrix
# there is function in GAP, however it does not seem to work for SL(d,q).

# Input: M: A Matrix

# Output: true if M is Monomial, false else

DeclareGlobalFunction( "TestIfMonomial" );



####################
# PART II - a)
#    UnipotentDecomposition and Transvections
####################

#####
# Transvections2()
#####

#  Let stdgens be the list of standard generators for SL(d,p^f)
#  and let omega be a primitive element of G(p^f).
#  This function computes T_2 := { t21(omega^ell) | 0 <= ell <= f-1 }
#  Record what we do in slp

# This function coincides with eq (6) p12

# Input: stdgens: The LGO standard-generators of SL(d,q)
#            omega: A primitive element of GF(q)
#            slp: A list of instructions
#            pos: A list of numbers, denoting where to save the transvections
#                    t_{2,1}(omega^ell)  0 <= ell < f

# Output: slp: The list of instruction with additional instructions writing
#                    t_{2,1}(\omega^ell) in Slot pos[l+1] 0 <= ell < f.

DeclareGlobalFunction( "Transvections2" );



#####
# UnipotentDecomposition()
#####
# Computes the Unitriangular decomposition of the matrix g

# Input:
#    stdgens: The LGO standard-generators
#    g:    a matrix in SL(d,q)

# Output: slp: A list of instructions yielding u1,u2 if evaluated as SLP
#        [u1,g,u2]: The matrices of Bruhat-Decomposition

DeclareGlobalFunction( "UnipotentDecomposition" );



####################
# PART II - b)
#    Basically the same as in II - a)
#    But now we save all Transvections
####################

# Compute the Bruhat decomposition of the matrix g, given
# the standard generators for the group.
# In this version we will store all the transvections t_i,i-1(w^l).
# this will increase the memory usage by (d-3)*f but reduce runtime

DeclareGlobalFunction( "UnipotentDecompositionWithTi" );



#####################
# PART III
#    Decomposition of Permutation and Diagonal-Matrix
####################

#####
# PermutationMonomialMatrix()
#####
# Find the permutation (in Sym(d) corresponding to a monomial matrix

# Input:    M: A monomial matrix

# Output:    diag: The vector of non-zero entries, where diag[i] is the non-zero
#                entry of row i.
#            perm: The  permutation associated to M
#                     (ie i^perm = j if M_i,j not 0)

DeclareGlobalFunction( "PermutationMonomialMatrix" );


#####
# PermSLP()
#####

# In this function we will transform a monomial matrix w \in SL(d,q) into
# a diagonal matrix diag. Using only the standard-generators s,v,x this
# will lead to a monomial matrix p_sign with only +-1 in non-zero entries
# and p_sign*diag = w (ie diag = p_sign^-1*w )
# Furthermore we will return list slp of instructions which will
# (when evaluated at the LGO standard-generators) yield diag.

# It is sufficient for diag to be diagonal, if the permutation associated
# with w (ie i^\pi_w = j if M_i,j not 0) is the inverse of the permutation
# associated to p_sign (again only to Sym(d) )

# In PermSLP we thus transform \pi_w to () using only { \pi_s, \pi_v, \pi_x }
# In order to know diag without computing all matrix multiplications,
# (we don't know the signs of p_sign), we compute a second permutation
# simultaneously (here using their identification with permutations in Sym(2d)
# and identifying { \pi_s, \pi_v, \pi_x } with {s,v,x} )

# Input:    stdgens:  The LGO standard-generators
#            mat:    A monomial matrix  (ie w)
#            slp:    An already existing list of instructions *optional

# Output:    slp: A list of instructions to evaluate p_sign
#                (if slp was Input then this instructions are added to slp)
#            p_sign: The signed permutation matrix
#            mat: the diagonal matrix diag

DeclareGlobalFunction( "PermSLP" );



#####
# DiagonalDecomposition()
#####

# Writes a list of instructions which evaluated on LGO standard-generators
# yield the diagonal matrix of the input.

# Input:    stdgens:    The LGO standard-generators
#            diag:        A diagonal matrix  (eg diag)
#            slp:    An already existing list of instructions *optional

# Output:    slp: A list of instructions to evaluate diag
#                (if slp was Input then this instructions are added to slp)
#            hres: The the identity matrix

DeclareGlobalFunction( "DiagonalDecomposition" );



####################
# PART IV
#    Main Functions. Constructs slp for the StraightLineProgram
#####################

#####
# BruhatDecomposition()
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

DeclareGlobalFunction( "BruhatDecomposition" );



#####
# BruhatDecompositionWithTi()
#####

# As BruhatDecomposition() but replace UnipotentDecomposition()
# by UnipotentDecompositionWithTi.

# Input: stdgens: The LGO standard-generators
#        g:    A matrix in SL(d,q)

# Output: pgr: A SLP to compute u1,u2,p_sign, diag
#                and all transvections t_{i,i-1}(omega^ell)
#            the matrices u1, u2, p_sign and diag itself

DeclareGlobalFunction( "BruhatDecompositionWithTi" );

#!     </Section>
#!     </Chapter>
