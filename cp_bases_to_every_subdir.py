import os
import shutil

from utils.utils import rel_path

# Get the current directory and parent directory
current_dir = rel_path(".")
parent_dir = os.path.dirname(current_dir)

# Find all files in the parent directory that start with "BASIS"
basis_files = [file for file in os.listdir(current_dir) if file.startswith("BASIS")]

# Iterate over all subdirectories in the current directory
for root, dirs, files in os.walk(current_dir):
    # Check if the current subdirectory contains .inp or .out files
    contains_inp_out = any(file.endswith(('.inp', '.out')) for file in files)
    
    if contains_inp_out:
        # Remove all .sh files in the current subdirectory
        for file in files:
            if file.endswith('.sh'):
                os.remove(os.path.join(root, file))
        
        # Copy all BASIS files from the parent directory to the current subdirectory
        for basis_file in basis_files:
            src_path = os.path.join(current_dir, basis_file)
            dest_path = os.path.join(root, basis_file)
            shutil.copy2(src_path, dest_path)
