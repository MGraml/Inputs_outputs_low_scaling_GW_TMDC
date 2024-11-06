import os
from utils.utils import rel_path

# Set the current directory as the starting point
start_dir = rel_path(".")

# Walk through all subdirectories and files
for root, dirs, files in os.walk(start_dir):
    # Initialize variables for inp file and project name
    inp_file = None
    project_name = None
    
    # Search for .out and .inp files in the current directory
    for file in files:
        if file.endswith('.out'):
            # Read the .out file to find the project name
            with open(os.path.join(root, file), 'r') as f:
                for line in f:
                    if line.strip().startswith("GLOBAL| Project name"):
                        # Extract the project name from the last column of the line
                        project_name = line.strip().split()[-1]
                        break  # Stop after finding the project name
        
        elif file.endswith('.inp'):
            # Store the .inp file name for renaming later
            inp_file = file
    
    # Rename the .inp file if both inp_file and project_name were found
    if inp_file and project_name:
        # If name has already project name, skip
        if project_name in file:
            break
        old_inp_path = os.path.join(root, inp_file)
        new_inp_name = f"{os.path.splitext(inp_file)[0]}_{project_name}.inp"
        new_inp_path = os.path.join(root, new_inp_name)
        
        # Rename the .inp file
        os.rename(old_inp_path, new_inp_path)
