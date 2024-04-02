import pandas as pd
import os

# Chemin du fichier CSV d'entrée
input_csv_file = input("Entrez le chemin du fichier CSV d'entrée : ")

# Chemin du répertoire cible où les fichiers découpés seront déposés
output_directory = input("Entrez le chemin du répertoire cible : ")

# Nom de base pour les fichiers de sortie
output_base_name = input("Entrez le nom de base pour les fichiers de sortie : ")

# Créer le répertoire de sortie s'il n'existe pas
if not os.path.exists(output_directory):
    os.makedirs(output_directory)

# Nombre de lignes à lire à chaque fois
chunksize = 1000  # Vous pouvez ajuster cette valeur selon vos besoins

# Compteur pour le nom des fichiers de sortie
file_counter = 1

# Lire le fichier CSV en chunks et écrire chaque chunk dans un fichier CSV
for chunk in pd.read_csv(input_csv_file, chunksize=chunksize, delimiter=';'):
    output_file = os.path.join(output_directory, f"{output_base_name}_{file_counter}.csv")
    chunk.to_csv(output_file, index=False)
    file_counter += 1

print("Fichiers découpés avec succès.")
