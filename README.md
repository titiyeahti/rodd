## RODD Groupe 3

Auteurs : Yuli Daune-Funato, Thibaut Milhaud

### Organisation des fichiers

Ce dépôt contient tous les tps de l'UE RODD à l'exception de celui réalisé sur exel.
Nous allons cependant nous concentrer sur les 4 premier tps.

#### Modèles OPL et instances de base

Les modèles OPL et les instances associées à chaque tp se trouve dans le dossier correspondant. 
Le modèle porte le nom `tpX.mod` dans chaque dossier.

#### Code C pour générer les instances

Le code source des programmes utilisé pour générer les instances se trouve dans le dossier `src/`.
Ce dossier contient :
- `gen_matrix.[hc]`, une librairie maison pour me simplifier la vie;
- `gen_inst_tpX.c`, un programme en C associé à chaque tp.

Il y a également un `Makefile` associé.

#### Utilitaires en bash 

La encore pour simplifier les manipulation, le projet contient 3 script bash :
- `gen_all.sh`, lance successivement les 4 générateurs d'instances;
- `init_plot.sh`, effaces les données accumulées jusqu'à présent;
- `run_inst.sh`, prend en argument un entier entre 1 et 4 et lance toutes les instances du tp correspondant.

**REMARQUE** : Dans `run_inst.sh` la commande appelée est liée à mon installation de CPLEX. Pensez à la modifier.

#### Usage

Pour compiler les générateurs :
```{sh}
$> make
```

Pour générer un nouveau jeu de test pour chaque tp :
```{sh}
$> make clear
$> make
$> ./gen_all.sh
```

Pour lancer les tests sur le tp `i` (*en ayant modifié le script* c.f. **REMARQUE**):
```{sh}
$> ./init_plot.sh
$> ./run_inst.sh i [1 ou 3] (si i==4)
```

Pour tracer des courbes (avec gnuplot installé) :
```{sh}
$> cd plot_data
$> gnuplot *.gpl
```

Pour modifier les paramètres de génération des instances, il faut malheureusement modifier les fichiers C.
