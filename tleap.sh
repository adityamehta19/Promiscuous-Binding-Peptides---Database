##INITIAL PDB GENERERATION##

tleap -s -f /home/system/miniconda3/dat/leap/cmd/leaprc.protein.ff19SB

> junk = sequence {TRP ALA GLY ALA LYS ARG LEU VAL LEU ARG ARG GLU}
> savepdb junk p7.pdb

# Similar script was used to generate all the peptides
# HIE was changed to HIS, which represents Histidine residue in the peptide
