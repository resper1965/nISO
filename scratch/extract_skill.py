import zipfile
import os

source = r'c:\Users\resper\OneDrive\Área de Trabalho\DESENVOLVIMENTO\niso\temp_grc_skills\ISO 27001 - Claude Skill\iso27001.skill'
dest = r'c:\Users\resper\OneDrive\Área de Trabalho\DESENVOLVIMENTO\niso\temp_grc_skills\iso27001_extracted'

if not os.path.exists(dest):
    os.makedirs(dest)

with zipfile.ZipFile(source, 'r') as zip_ref:
    zip_ref.extractall(dest)

print(f"Extracted to {dest}")
