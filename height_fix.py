# put in osm data directory and run
import os
from pathlib import Path
os.system('gzip -rd /home/pat/projects/bothell_import/scripts/osm')
directory = Path('/home/pat/projects/bothell_import/scripts/osm')
for filename in directory.iterdir():
    with open(filename, 'r') as file:
        filedata = file.read()

    # Replace the target string
    filedata = filedata.replace('', '')

    # Write the file out again
    with open(filename, 'w') as file:
        file.write(filedata)
os.system('gzip -r /home/pat/projects/bothell_import/scripts/osm')
