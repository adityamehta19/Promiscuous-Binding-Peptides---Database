gmx_d editconf -f combined.pdb -o box-init.gro -d 1 -resnr 1
gmx_d editconf -f box-init.gro -o box.gro -box 10 10 10 -c
gmx_d editconf -f box.gro -o box-shift.gro -center 5 5 2

#Vacuum Minimization
gmx_d grompp -f minim.mdp -c box-shift.gro -p topol.top -o em-vac.tpr -maxwarn 1
gmx_d mdrun -v -deffnm em-vac

#Solvation
Copy the same tip3p.gro from any peptide folder
gmx_d solvate -cp em-vac.gro -cs tip3p.gro -p topol.top -o solvate.gro

#Addition of Ions
gmx_d grompp -f ions.mdp -c solvate.gro -p topol.top -o ions.tpr
echo 15 | gmx_d genion -s ions.tpr -p topol.top -o del.gro -pname NA -nname CL -conc 0.150 -neutral

#From here, the simulation was resumed using SuperComputer - PARAMANANTA
#Solution Minimization
gmx_d grompp -f minim.mdp -c del.gro -p topol.top -o em-sol.tpr
gmx_d mdrun -v -deffnm em-sol

#NVT Run - 1 ns
mpirun -n 1 gmx_mpi grompp -f nvt.mdp -c em-sol.gro -p topol.top -o nvt.tpr
mpirun -np 48 gmx_mpi mdrun -v -deffnm nvt

#NPT Run - 1 ns
mpirun -n 1 gmx_mpi grompp -f npt.mdp -c nvt.gro -t nvt.cpt -p topol.top -o npt.tpr
mpirun -np 48 gmx_mpi mdrun -v -deffnm npt

#Production Run - 150 ns
mpirun -n 1 gmx_mpi grompp -f prod.mdp -c npt.gro -t npt.cpt -p topol.top -o prod.tpr
mpirun -np 48 gmx_mpi mdrun -v -deffnm prod
