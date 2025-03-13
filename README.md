# Calculatrice Flutter
Description
Cette application Flutter implémente une calculatrice de base avec des fonctionnalités telles que l'addition, la soustraction, la multiplication et la division. L'application met à jour l'affichage en temps réel, tout en permettant à l'utilisateur d'effectuer des calculs. Les calculs sont réalisés une fois que l'utilisateur appuie sur le bouton égal (=).

Fonctionnalités
Calculs de base : Addition, soustraction, multiplication, division.
Affichage dynamique : Affichage de l'expression en cours et du résultat.
Animations : Animation de l'affichage lors de l'appui sur les boutons.
Gestion des erreurs : Affichage d'erreurs en cas de division par zéro.
Choix Techniques
### 1. Flutter et Dart
Flutter a été choisi pour sa capacité à créer des applications multiplateformes avec une interface fluide et réactive. Dart, le langage derrière Flutter, permet une gestion simple et efficace des interactions.
### 2. StatefulWidget
Un StatefulWidget est utilisé pour gérer l'état de la calculatrice. Chaque modification de l'interface, comme la saisie de chiffres ou le calcul du résultat, déclenche une mise à jour dynamique de l'affichage.
### 3. Animations
Des animations sont utilisées pour rendre l'interface utilisateur plus fluide et agréable, en particulier lors de l'appui sur les boutons.
## Difficultés rencontrées
### 1. Calculs en chaîne
Dans cette version, l'application ne supporte pas les calculs en chaîne (où les résultats sont mis à jour immédiatement après chaque opérateur sans attendre le bouton égal). Cela aurait nécessité une gestion plus complexe des entrées et des calculs intermédiaires.
Solution : Actuellement, l'application attend que l'utilisateur appuie sur "=" pour effectuer un calcul. Si nous voulons ajouter des calculs en chaîne, il faudra gérer les résultats intermédiaires et l'état des calculs au fur et à mesure que les opérateurs sont saisis.
### 2. Gestion des erreurs
Il a fallu gérer les erreurs de division par zéro et les entrées malformées (par exemple, un utilisateur appuyant sur deux opérateurs consécutifs).
Solution : Nous avons intégré une gestion simple pour renvoyer "Erreur" lorsque des opérations impossibles sont effectuées.

![image](https://github.com/user-attachments/assets/96b83779-3c5f-46ca-8f3b-3d4a9fb33f46)
