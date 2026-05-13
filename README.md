<div align="center">

# 🚗 Tableau de Bord — UAL en VHDL

**Projet de Conception Électronique **

![Language](https://img.shields.io/badge/Language-VHDL-blue?style=for-the-badge&logo=xilinx)
![Tool](https://img.shields.io/badge/Tool-Vivado-red?style=for-the-badge&logo=xilinx)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge)
![School](https://img.shields.io/badge/School-SUP'COM-purple?style=for-the-badge)
![Year](https://img.shields.io/badge/Year-2025%2F2026-orange?style=for-the-badge)

*Réalisé par **Elaa Affes** — École Supérieure des Communications de Tunis*

</div>

---

## 📌 Table des matières

1. [Description du projet](#-description-du-projet)
2. [Structure du projet](#-structure-du-projet)
3. [Lancer le projet sur Vivado](#-lancer-le-projet-sur-vivado)
4. [UAL — Module principal](#-ual--module-principal)
5. [Multiplication 4 bits](#1️⃣-multiplication-4-bits)
6. [Compteur Synchrone à Cycle Aléatoire](#2️⃣-compteur-synchrone-à-cycle-aléatoire)
7. [Compteur Asynchrone Binaire](#3️⃣-compteur-asynchrone-binaire)
8. [Registre à Décalage](#4️⃣-registre-à-décalage)
9. [LFSR — Registre à Séquence Pseudo-Aléatoire](#5️⃣-lfsr--registre-à-séquence-pseudo-aléatoire)
10. [Codeur / Décodeur](#6️⃣-codeur--décodeur)
11. [Machine à États — Essuie-Glace (Mealy)](#7️⃣-machine-à-états--essuie-glace-mealy)
12. [Afficheur 7 Segments](#8️⃣-afficheur-7-segments)
13. [Table de sélection SEL](#-table-de-sélection-sel)
14. [.gitignore recommandé](#-gitignore-recommandé)

---

## 📖 Description du projet

**Objectif :** Réaliser une **Unité Arithmétique et Logique (UAL)** en VHDL qui simule le tableau de bord d'une voiture. L'UAL regroupe 8 modules fonctionnels sélectionnables via un signal `SEL` 4 bits.

| Module | Fichier VHDL | Rôle dans la voiture |
|---|---|---|
| Multiplication 4 bits | `Multiplication_4bit.vhd` | Calcul de distance restante |
| Compteur Synchrone | `Compteur_Synchrone.vhd` | Test des capteurs au démarrage |
| Compteur Asynchrone | `Compteur_Asynchrone.vhd` | Comptage de la vitesse moteur |
| Registre à Décalage | `Reg_Decalage.vhd` | Animation des clignotants |
| LFSR | `LFSR_UAL.vhd` | Génération du code de clé sans fil |
| Codeur / Décodeur | `Decodeur_UAL.vhd` | Position du levier de vitesse (P/R/N/D) |
| Machine à États (Mealy) | `Essuie_Glace_Mealy.vhd` | Gestion des essuie-glaces |
| Afficheur 7 Segments | `Affichage_UAL.vhd` | Affichage du rapport engagé |

**Entrées / Sorties communes de l'UAL :**

| Signal | Direction | Taille | Description |
|---|---|---|---|
| `CLK` | Entrée | 1 bit | Horloge système |
| `RESET` | Entrée | 1 bit | Remise à zéro synchrone |
| `A` | Entrée | 4 bits | Opérande A |
| `B` | Entrée | 4 bits | Opérande B |
| `SEL` | Entrée | 4 bits | Sélection du module actif |
| `S` | Sortie | 8 bits | Résultat du module sélectionné |

---

## 📁 Structure du projet

```
projet vivado/
│
├── UAL.vhd                  → Module principal (top-level) + multiplexeur SEL
├── Multiplication_4bit.vhd  → Multiplication A × B sur 4 bits
├── Compteur_Synchrone.vhd   → Compteur synchrone à séquence aléatoire
├── Compteur_Asynchrone.vhd  → Compteur asynchrone binaire 4 bits
├── Reg_Decalage.vhd         → Registre à décalage gauche/droite
├── LFSR_UAL.vhd             → Registre à rétroaction linéaire (LFSR 8 bits)
├── Decodeur_UAL.vhd         → Décodeur 2 vers 4 (levier de vitesse)
├── Essuie_Glace_Mealy.vhd   → Machine à états Mealy (essuie-glaces)
└── Affichage_UAL.vhd        → Encodeur pour afficheur 7 segments
```

---

## 💻 Lancer le projet sur Vivado

### Étape 1 — Prérequis

- **Xilinx Vivado** installé (version 2020.x ou supérieure recommandée)
- Téléchargeable sur : [https://www.xilinx.com/support/download.html](https://www.xilinx.com/support/download.html)

### Étape 2 — Créer un nouveau projet

1. Ouvrir **Vivado**
2. Cliquer sur **Create Project**
3. Choisir un nom et un dossier de destination
4. Sélectionner **RTL Project**
5. Cliquer **Next** jusqu'à la page de sélection des fichiers

### Étape 3 — Ajouter les fichiers VHDL

1. Dans **Add Sources**, cliquer **Add Files**
2. Sélectionner **tous les fichiers `.vhd`** du dossier `projet vivado/`
3. Cocher **Copy sources into project**
4. Cliquer **Finish**

> ⚠️ S'assurer que `UAL.vhd` est défini comme **top-level** :  
> Clic droit sur `UAL` dans le panneau *Sources* → **Set as Top**

### Étape 4 — Simulation (Behavioral Simulation)

1. Dans le panneau de gauche : **Flow Navigator → Simulation → Run Simulation**
2. Cliquer **Run Behavioral Simulation**
3. La fenêtre de waveform s'ouvre — ajouter les signaux `A`, `B`, `SEL`, `S`, `CLK`, `RESET`

**Exemple de testbench — signaux à forcer :**

```vhdl
-- Exemple de stimuli pour tester la multiplication (SEL = "0000")
CLK   <= not CLK after 5 ns;
RESET <= '1', '0' after 20 ns;
A     <= "0011";   -- A = 3
B     <= "0100";   -- B = 4
SEL   <= "0000";   -- Module : Multiplication
-- Résultat attendu sur S : "00001100" (= 12)
```

### Étape 5 — Synthèse et Implémentation (optionnel)

```
Flow Navigator → Synthesis → Run Synthesis
Flow Navigator → Implementation → Run Implementation
Flow Navigator → Generate Bitstream
```

---

## 🔀 UAL — Module principal

Le module `UAL.vhd` instancie les 8 composants et sélectionne la sortie active via un **multiplexeur** contrôlé par `SEL`.

```vhdl
-- UAL.vhd — Sélection du module actif
process (SEL, s_mult, s_cpt_sync, s_cpt_async, s_reg_dec,
         s_lfsr, s_decodeur, s_mealy, s_aff_7seg)
begin
    case SEL is
        when "0000" => S <= s_mult;        -- Multiplication
        when "0001" => S <= s_cpt_sync;    -- Compteur Synchrone
        when "0010" => S <= s_cpt_async;   -- Compteur Asynchrone
        when "0011" => S <= s_reg_dec;     -- Registre à Décalage
        when "0100" => S <= s_lfsr;        -- LFSR
        when "0101" => S <= s_decodeur;    -- Décodeur
        when "0110" => S <= s_mealy;       -- Essuie-Glace
        when "0111" => S <= s_aff_7seg;    -- Afficheur 7 Segments
        when others => S <= "00000000";
    end case;
end process;
```

---

## 1️⃣ Multiplication 4 bits

### Rôle dans la voiture
Calculer la **distance restante à parcourir** à partir de la consommation et du carburant.

### Principe
Multiplication non signée de deux opérandes 4 bits → résultat sur 8 bits.

```
Résultat = A × B     (0 à 15) × (0 à 15) = 0 à 225
```

### Code VHDL — `Multiplication_4bit.vhd`

```vhdl
entity Multiplication_4bit is
    Port ( A   : in  STD_LOGIC_VECTOR (3 downto 0);
           B   : in  STD_LOGIC_VECTOR (3 downto 0);
           Res : out STD_LOGIC_VECTOR (7 downto 0));
end Multiplication_4bit;

architecture Behavioral of Multiplication_4bit is
begin
    Res <= std_logic_vector(unsigned(A) * unsigned(B));
end Behavioral;
```

### Exemple

| A (4 bits) | B (4 bits) | Résultat S (8 bits) | Valeur décimale |
|---|---|---|---|
| `0011` (3) | `0100` (4) | `00001100` | **12** |
| `1111` (15) | `1111` (15) | `11100001` | **225** |
| `0101` (5) | `0110` (6) | `00011110` | **30** |

---

## 2️⃣ Compteur Synchrone à Cycle Aléatoire

### Rôle dans la voiture
Tester les **capteurs de la voiture au démarrage** en parcourant une séquence d'états prédéfinie.

### Principe
Compteur synchrone (déclenché sur front montant de CLK) qui suit une **séquence fixe non linéaire** :

```
0000 → 0101 → 1010 → 0011 → 1111 → (puis +1 pour tout autre état)
```

### Code VHDL — `Compteur_Synchrone.vhd`

```vhdl
process(CLK, Reset)
begin
    if Reset = '1' then
        temp <= "0000";
    elsif rising_edge(CLK) then
        case temp is
            when "0000" => temp <= "0101";
            when "0101" => temp <= "1010";
            when "1010" => temp <= "0011";
            when "0011" => temp <= "1111";
            when others => temp <= temp + 1;
        end case;
    end if;
end process;
```

### Séquence des états

| Cycle | État courant | État suivant |
|---|---|---|
| 1 | `0000` (0) | `0101` (5) |
| 2 | `0101` (5) | `1010` (10) |
| 3 | `1010` (10) | `0011` (3) |
| 4 | `0011` (3) | `1111` (15) |
| 5+ | autres | +1 (séquentiel) |

---

## 3️⃣ Compteur Asynchrone Binaire

### Rôle dans la voiture
Compter la **vitesse de rotation du moteur (RPM)** — chaque front d'horloge correspond à un tour moteur.

### Principe
Compteur **4 bits asynchrone** : chaque bascule est déclenchée par le front **descendant** de la sortie de la bascule précédente (ripple counter).

```
Q0 : déclenché sur front descendant de CLK
Q1 : déclenché sur front descendant de Q0
Q2 : déclenché sur front descendant de Q1
Q3 : déclenché sur front descendant de Q2
```

### Code VHDL — `Compteur_Asynchrone.vhd`

```vhdl
-- Bascule Q0 (déclenchée par CLK)
process(CLK, Reset)
begin
    if Reset = '1' then q_int(0) <= '0';
    elsif falling_edge(CLK) then q_int(0) <= not q_int(0);
    end if;
end process;

-- Bascule Q1 (déclenchée par Q0)
process(q_int(0), Reset)
begin
    if Reset = '1' then q_int(1) <= '0';
    elsif falling_edge(q_int(0)) then q_int(1) <= not q_int(1);
    end if;
end process;
-- (idem pour Q2 et Q3)
```

### Exemple de comptage

| CLK (fronts descendants) | Q3 | Q2 | Q1 | Q0 | Valeur |
|---|---|---|---|---|---|
| 0 | 0 | 0 | 0 | 0 | **0** |
| 1 | 0 | 0 | 0 | 1 | **1** |
| 2 | 0 | 0 | 1 | 0 | **2** |
| 3 | 0 | 0 | 1 | 1 | **3** |
| ... | ... | ... | ... | ... | ... |
| 15 | 1 | 1 | 1 | 1 | **15** |

---

## 4️⃣ Registre à Décalage

### Rôle dans la voiture
Animer la **lumière des clignotants** — les LEDs s'allument progressivement de gauche à droite ou de droite à gauche.

### Principe
Registre 4 bits avec décalage **gauche ou droite** selon le bit `A(0)` :

```
A(0) = '0'  →  Décalage gauche  (insertion de A(1) à droite)
A(0) = '1'  →  Décalage droite (insertion de A(1) à gauche)
```

### Code VHDL — `Reg_Decalage.vhd`

```vhdl
process(CLK, Reset)
begin
    if Reset = '1' then
        tmp <= "0000";
    elsif rising_edge(CLK) then
        if A(0) = '0' then
            tmp <= tmp(2 downto 0) & A(1);   -- Décalage gauche
        else
            tmp <= A(1) & tmp(3 downto 1);   -- Décalage droite
        end if;
    end if;
end process;
```

### Exemple — Décalage gauche (A = `0000`, bit entrant = 1)

| Cycle | tmp avant | Opération | tmp après |
|---|---|---|---|
| 1 | `0000` | shift left, in=1 | `0001` |
| 2 | `0001` | shift left, in=1 | `0011` |
| 3 | `0011` | shift left, in=1 | `0111` |
| 4 | `0111` | shift left, in=1 | `1111` |

---

## 5️⃣ LFSR — Registre à Séquence Pseudo-Aléatoire

### Rôle dans la voiture
Générer un **code de sécurité changeant** à chaque démarrage pour le système de clé sans fil (keyless entry).

### Principe
LFSR (**Linear Feedback Shift Register**) 8 bits avec polynôme de rétroaction :

```
Nouveau bit = reg(7) XOR reg(2)
Registre décalé à gauche, nouveau bit inséré à droite
```

État initial : `00000001` (seed)

### Code VHDL — `LFSR_UAL.vhd`

```vhdl
signal reg : STD_LOGIC_VECTOR(7 downto 0) := "00000001";

process(CLK)
begin
    if rising_edge(CLK) then
        if Reset = '1' then
            reg <= "00000001";
        else
            reg <= reg(6 downto 0) & (reg(7) xor reg(2));
        end if;
    end if;
end process;
S <= reg;
```

### Séquence pseudo-aléatoire (premiers états)

| Cycle | Registre (binaire) | Valeur hex |
|---|---|---|
| 0 | `00000001` | `0x01` |
| 1 | `00000010` | `0x02` |
| 2 | `00000100` | `0x04` |
| 3 | `00001000` | `0x08` |
| 4 | `00010001` | `0x11` |
| 5 | `00100010` | `0x22` |
| ... | ... | ... |

> Le registre génère jusqu'à **255 états distincts** avant de se répéter (séquence maximale pour 8 bits).

---

## 6️⃣ Codeur / Décodeur

### Rôle dans la voiture
Traduire la **position physique du levier de vitesse** en signal numérique pour afficher le mode correspondant : **P** (Park), **R** (Reverse), **N** (Neutral), **D** (Drive).

### Principe
Décodeur **2 vers 4** : les 2 bits de poids faible de `A` sélectionnent une sortie parmi 4 (one-hot encoding).

```
A(1:0) = "00"  →  S(3:0) = "0001"  (P — Park)
A(1:0) = "01"  →  S(3:0) = "0010"  (R — Reverse)
A(1:0) = "10"  →  S(3:0) = "0100"  (N — Neutral)
A(1:0) = "11"  →  S(3:0) = "1000"  (D — Drive)
```

### Code VHDL — `Decodeur_UAL.vhd`

```vhdl
process(A)
begin
    S <= (others => '0');
    case A(1 downto 0) is
        when "00" => S(3 downto 0) <= "0001";  -- P
        when "01" => S(3 downto 0) <= "0010";  -- R
        when "10" => S(3 downto 0) <= "0100";  -- N
        when "11" => S(3 downto 0) <= "1000";  -- D
        when others => S <= (others => '0');
    end case;
end process;
```

### Table de vérité

| A(1:0) | S(3:0) | Mode affiché |
|---|---|---|
| `00` | `0001` | **P** — Parking |
| `01` | `0010` | **R** — Marche arrière |
| `10` | `0100` | **N** — Point mort |
| `11` | `1000` | **D** — Marche avant |

---

## 7️⃣ Machine à États — Essuie-Glace (Mealy)

### Rôle dans la voiture
Gérer les **trois modes des essuie-glaces** selon l'intensité de pluie détectée par un capteur.

### Principe
Machine à états de **type Mealy** avec 3 états :

```
ST_OFF    (00) → Essuie-glaces arrêtés
ST_LENT   (01) → Mode continu lent
ST_RAPIDE (10) → Mode rapide
```

Les transitions dépendent du signal d'entrée `A(1:0)` (commande conducteur).

### Diagramme de transitions

```
         A="01"              A="10"
    ┌──────────────┐    ┌──────────────┐
    │              ▼    │              ▼
 [ST_OFF] ──────► [ST_LENT] ──────► [ST_RAPIDE]
    ▲              │    ▲              │
    └──── A="00" ──┘    └──── A="00" ──┘
```

### Code VHDL — `Essuie_Glace_Mealy.vhd`

```vhdl
-- Processus de transition d'état
process(CLK, Reset)
begin
    if Reset = '1' then current_s <= ST_OFF;
    elsif rising_edge(CLK) then current_s <= next_s;
    end if;
end process;

-- Processus de sortie + état suivant
process(current_s, A)
begin
    S <= (others => '0');
    case current_s is
        when ST_OFF =>
            S(1 downto 0) <= "00";
            if    A(1 downto 0) = "01" then next_s <= ST_LENT;
            elsif A(1 downto 0) = "10" then next_s <= ST_RAPIDE;
            else                             next_s <= ST_OFF;   end if;
        when ST_LENT =>
            S(1 downto 0) <= "01";
            if    A(1 downto 0) = "00" then next_s <= ST_OFF;
            elsif A(1 downto 0) = "10" then next_s <= ST_RAPIDE;
            else                             next_s <= ST_LENT;  end if;
        when ST_RAPIDE =>
            S(1 downto 0) <= "10";
            if    A(1 downto 0) = "00" then next_s <= ST_OFF;
            elsif A(1 downto 0) = "01" then next_s <= ST_LENT;
            else                             next_s <= ST_RAPIDE; end if;
    end case;
end process;
```

### Table de transitions

| État actuel | Entrée A(1:0) | État suivant | Sortie S(1:0) |
|---|---|---|---|
| ST_OFF | `00` | ST_OFF | `00` |
| ST_OFF | `01` | ST_LENT | `00` |
| ST_OFF | `10` | ST_RAPIDE | `00` |
| ST_LENT | `00` | ST_OFF | `01` |
| ST_LENT | `01` | ST_LENT | `01` |
| ST_LENT | `10` | ST_RAPIDE | `01` |
| ST_RAPIDE | `00` | ST_OFF | `10` |
| ST_RAPIDE | `01` | ST_LENT | `10` |
| ST_RAPIDE | `10` | ST_RAPIDE | `10` |

---

## 8️⃣ Afficheur 7 Segments

### Rôle dans la voiture
Afficher le **rapport de vitesse engagé** (P, R, N, D) sur un afficheur 7 segments physique.

### Principe
Encodeur qui convertit les 2 bits de position du levier en **segments actifs** de l'afficheur 7 segments (encodage actif à `0`).

```
A(1:0) = "00"  →  Affiche "P"
A(1:0) = "01"  →  Affiche "R"
A(1:0) = "10"  →  Affiche "N"
A(1:0) = "11"  →  Affiche "d"
```

### Code VHDL — `Affichage_UAL.vhd`

```vhdl
process(A)
begin
    S <= (others => '1');    -- éteindre tous les segments par défaut
    case A(1 downto 0) is
        when "00" => S(6 downto 0) <= "0001100";  -- P
        when "01" => S(6 downto 0) <= "0101111";  -- R
        when "10" => S(6 downto 0) <= "0101011";  -- N
        when "11" => S(6 downto 0) <= "0100001";  -- d
        when others => S(6 downto 0) <= "1111111"; -- tout éteint
    end case;
end process;
```

### Segments 7 segments (format : `gfedcba`)

| A(1:0) | Segments `gfedcba` | Lettre affichée |
|---|---|---|
| `00` | `0001100` | **P** |
| `01` | `0101111` | **R** |
| `10` | `0101011` | **N** |
| `11` | `0100001` | **d** |

---

## 📊 Table de sélection SEL

Résumé complet du multiplexeur de l'UAL :

| SEL (4 bits) | Module sélectionné | Fichier VHDL | Rôle voiture |
|---|---|---|---|
| `0000` | Multiplication | `Multiplication_4bit.vhd` | Distance restante |
| `0001` | Compteur Synchrone | `Compteur_Synchrone.vhd` | Test capteurs démarrage |
| `0010` | Compteur Asynchrone | `Compteur_Asynchrone.vhd` | RPM moteur |
| `0011` | Registre à Décalage | `Reg_Decalage.vhd` | Clignotants |
| `0100` | LFSR | `LFSR_UAL.vhd` | Code clé sans fil |
| `0101` | Décodeur | `Decodeur_UAL.vhd` | Levier P/R/N/D |
| `0110` | Essuie-Glace (Mealy) | `Essuie_Glace_Mealy.vhd` | Essuie-glaces |
| `0111` | Afficheur 7 Segments | `Affichage_UAL.vhd` | Affichage rapport |
| `1000`–`1111` | — | — | Sortie `00000000` |

---

## 🚫 .gitignore recommandé

```gitignore
# Vivado generated files
*.jou
*.log
*.str
*.dcp
*.xpr

# Simulation
*.wdb
*.wcfg

# Synthesis / Implementation
.Xil/
runs/
*.bit
*.ltx

# Cache
.cache/
.ip_user_files/
```

---

<div align="center">

---

Réalisé par **Elaa Affes**
SUP'COM — École Supérieure des Communications de Tunis | 2025/2026

</div>
