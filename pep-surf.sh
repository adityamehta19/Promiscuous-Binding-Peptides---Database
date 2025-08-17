##PEPTIDE-SURFACE SYSTEM GENERATION##
#Extracting equilibrated conformations of the peptides
gmx_d trjconv -f prod.gro -s prod.tpr -o peptide.pdb -pbc mol

#Origin of the system folder
#make a system folder and make different folder for different peptides in it.
#Transfer these: prot.itp, peptide.pdb, gold111.pdb, charmm folder, toppar folder.
#Dont transfer .mdp parameter files

#merge two pdb - first gold111 and then the peptide - name it combined.pdb
#gold111.pdb was generated using CHARMM-GUI
cat gold111.pdb peptide.pdb > combined.pdb

#Then, setting the coordinates of the peptides properly so that minimum coordinate of the peptide is at a distance of 1 nm from the maximum coordinate of the Au(111) surface

#TCL script for knowing the maximum coordinate of the surface (which has to be done only once)
set molID 0
set maxZ -inf
set allAtoms [atomselect $molID all]
set zCoords [$allAtoms get z]

foreach z $zCoords {
    if {$z > $maxZ} {
        set maxZ $z
    }
}

puts "The maximum Z coordinate is: $maxZ"

#TCL script for Knowing the minimum coordinate of the peptide (has to done for all the peptides)
set molID 0
set minZ +inf
set allAtoms [atomselect $molID all]
set zCoords [$allAtoms get z]

foreach z $zCoords {
    if {$z < $minZ} {
        set minZ $z
    }
}

puts "The minimum Z coordinate is: $minZ"

#Moving the coordinates of the peptide, You need to do this in peptide.pdb only
set set [atomselect top all]
$sel moveby {x y z}
$sel savepdb peptide.pdb
(Same name only)
Combine it again, name: combined.pdb only
Check the placement of the peptide again.
If it feels like, its in center, then x and y axis are done and if not, repeat this step again moving the peptide in peptide.pdb appropriately

#After the orientation of the peptide in all 3 axis, name the new peptide file as final.pdb

#Combine gold111.pdb and final.pdb, this is your combined.pdb finally
