# Python code to extract 100 time stamps from Sum-surf-prot.xvg

import statistics

def extract_qualifying_times(xvg_file_path, energy_min, energy_max, max_count=100):
    qualifying_times = []
    with open(xvg_file_path, 'r') as file:
        for line in file:
            if line.startswith('#') or line.startswith('@') or not line.strip():
                continue
            parts = line.split()
            if len(parts) < 2:
                continue
            time = float(parts[0])
            energy = float(parts[1])
            if energy_min <= energy <= energy_max:
                qualifying_times.append(int(time)/10)
                if len(qualifying_times) == max_count:
                    break
    return qualifying_times

def calculate_average_energy(xvg_file_path):
    energies = []
    with open(xvg_file_path, 'r') as file:
        for line in file:
            if line.startswith('#') or line.startswith('@') or not line.strip():
                continue
            parts = line.split()
            if len(parts) < 2:
                continue
            try:
                energy = float(parts[1])
                energies.append(energy)
            except ValueError:
                continue
    return statistics.mean(energies) if energies else None


xvg_file = 'Sum-surf-prot.xvg'  # <-- Change this if needed

# Calculate the average energy
average_energy = calculate_average_energy(xvg_file)

if average_energy is not None:
    # Define the new energy window based on the average
    new_energy_min = average_energy - 5
    new_energy_max = average_energy + 10

    print(f"Calculated Average Energy: {average_energy}")
    print(f"New Energy Window: {new_energy_min} to {new_energy_max}")

    # Extract timestamps using the new energy window
    times = extract_qualifying_times(xvg_file, energy_min=new_energy_min, energy_max=new_energy_max)

    # Save timestamps to file
    with open('fr.ndx', 'w') as f:
        f.write('[Frame no]\n')
        for t in times:
            f.write(f"{t}\n")
    print("Timestamps saved to 'fr.ndx'")

else:
    print(f"Could not calculate average energy from {xvg_file}. Please check the file format.")
