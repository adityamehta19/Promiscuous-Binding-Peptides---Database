##SYSTEM GENERATION##
gmx_d pdb2gmx -f p*.pdb -o conf.gro -ter -ignh
#Selecting CHARMM36 force field
#Selecting tip3p water model
#Selecting NH3+ and COO- as the terminals

#Editing the topology and seperating prot.itp separate for all the peptides
#Hence, making a generalized topology for all the systems
#Commenting out the posre.itp line since we are not applying restraints

#Now, we have conf.gro, generalized topology file (named topol.top) and prot.itp file specific for all peptides

gmx_d editconf -f conf.gro -o p*.pdb

#Making system box
gmx_d editconf -f "$i".pdb -o box-init.gro -d 1 -resnr 1
gmx_d editconf -f box-init.gro -o box.gro -box 9 9 9 -c
gmx_d editconf -f box.gro -o box-shift.gro -center 4.5 4.5 4.5

#Vacuum Minimization
gmx_d grompp -f minim.mdp -c box-shift.gro -p topol.top -o em-vac.tpr -maxwarn 1
gmx_d mdrun -v -deffnm em-vac

#Solvation
#Adding tip3p.gro file in all system folders required for solvation
gmx_d solvate -cp em-vac.gro -cs tip3p.gro -p topol.top -o solvate.gro

#Addition of Ions - Neutralization and adding concentration of 0.15 M
gmx_d grompp -f ions.mdp -c solvate.gro -p topol.top -o ions.tpr
gmx_d genion -s ions.tpr -p topol.top -o del.gro -pname NA -nname CL -conc 0.150 -neutral
#Replacing water molecules for addition of ions


#From here, the simulation was resumed using SuperComputer - PARAMANANTA
#Solution Minimization
gmx_d grompp -f minim.mdp -c del.gro -p topol.top -o em-sol.tpr
gmx_d mdrun -v -deffnm em-sol

#NVT Run
mpirun -n 1 gmx_mpi grompp -f nvt.mdp -c em-sol.gro -p topol.top -o nvt.tpr
mpirun -np 48 gmx_mpi mdrun -v -deffnm nvt

#NPT Run
mpirun -n 1 gmx_mpi grompp -f npt.mdp -c nvt.gro -t nvt.cpt -p topol.top -o npt.tpr
mpirun -np 48 gmx_mpi mdrun -v -deffnm npt

#Production Run for 20 ns
mpirun -n 1 gmx_mpi grompp -f prod.mdp -c npt.gro -t npt.cpt -p topol.top -o prod.tpr
mpirun -np 48 gmx_mpi mdrun -v -deffnm prod


#End of Production, we will have prod.gro, prod.cpt, prod.tpr, prod.xtc files for respective peptides
