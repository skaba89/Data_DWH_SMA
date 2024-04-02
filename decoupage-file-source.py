import argparse
import pandas as pd
import os
import shutil

def main(input_csv_file, output_directory, output_base_name):
    # Créer le répertoire de sortie s'il n'existe pas
    if not os.path.exists(output_directory):
        os.makedirs(output_directory)

    # Compteur pour le nom des fichiers de sortie
    file_counter = 1

    # Lire le fichier CSV pour obtenir le nombre total de lignes
    total_lines = sum(1 for line in open(input_csv_file))

    # Si le nombre de lignes est inférieur ou égal à 1000, copier simplement le fichier dans le répertoire cible
    if total_lines <= 1000:
        output_file = os.path.join(output_directory, f"{output_base_name}.csv")
        shutil.copy(input_csv_file, output_file)
        print("Fichier copié avec succès.")
        return

    # Nombre de lignes à lire à chaque fois
    chunksize = 1000  # Vous pouvez ajuster cette valeur selon vos besoins

    # Lire le fichier CSV en chunks et écrire chaque chunk dans un fichier CSV
    for i in range(0, total_lines, chunksize):
        chunk = pd.read_csv(input_csv_file, skiprows=i, nrows=chunksize, delimiter=';')
        output_file = os.path.join(output_directory, f"{output_base_name}_{file_counter}.csv")
        chunk.to_csv(output_file, index=False)
        file_counter += 1

    print("Fichiers découpés avec succès.")

if __name__ == "__main__":
    # Créer un analyseur d'arguments en ligne de commande
    parser = argparse.ArgumentParser(description="Découper un fichier CSV en plusieurs petits fichiers CSV.")
    parser.add_argument("input_csv_file", type=str, help="Chemin du fichier CSV d'entrée.")
    parser.add_argument("output_directory", type=str, help="Chemin du répertoire cible où les fichiers découpés seront déposés.")
    parser.add_argument("output_base_name", type=str, help="Nom de base pour les fichiers de sortie.")

    # Analyser les arguments
    args = parser.parse_args()

    # Appeler la fonction principale avec les arguments fournis
    main(args.input_csv_file, args.output_directory, args.output_base_name)
