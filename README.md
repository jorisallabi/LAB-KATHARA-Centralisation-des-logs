# LAB-KATHARA-Centralisation-des-logs
Ce LAB contient la configuration et les nécessaires pour centraliser les logs avec la suite ELK Stack


README pour le Lab DNS et Routage
Introduction
Pour notre projet, nous utiliserons cette architecture réseau qui est constituée de 9 routeurs, 4 serveurs DNS (Rootdns, Itdns, R3dns et ldns), 1 serveur WEB et un client. L’architecture est structurée en systèmes autonomes (AS) qui sont hiérarchisés en 3 niveaux. Le routage dynamique est géré par BGP, tandis que le protocole de routage RIP est utilisé pour les routeurs à l’intérieur des AS.
Architecture Réseau
Niveau 1
    • AS1 (rootdns): Contient le serveur DNS racine qui est relié à deux autres systèmes autonomes (AS) : AS20 et AS30.
Niveau 2
    • AS20 (itdns):
        ◦ Serveur DNS: itdns
        ◦ Liens: Connecté à AS1, AS100, AS30, et AS200.
        ◦ Nombre de routeurs: 3
    • AS30 (ldns):
        ◦ Serveur DNS: ldns
        ◦ Liens: Connecté à AS1 et AS200.
        ◦ Nombre de routeurs: 1
Niveau 3
    • AS200 (pc client):
        ◦ Client: pc client
        ◦ Liens: Connecté à AS20 et AS30 pour le load balancing.
    • AS100 (r3dns):
        ◦ Serveur DNS: r3dns
        ◦ Liens: Connecté à AS20 via deux liaisons pour le backup link.
Équipements
Routeurs
    • Total: 9 routeurs
    • AS100 et AS20: Chacun a 3 routeurs.
    • AS1, AS30 et AS200: Chacun a 1 routeur.
Serveurs DNS
    • rootdns: Serveur racine.
    • itdns: Serveur maître de la zone "it".
    • r3dns: Serveur maître de la zone "uniroma3.it".
    • ldns: Serveur DNS utilisé par le PC client, non maître de zone.
Serveur Web
    • Hébergé dans la zone "uniroma3.it".
Client
    • PC Client: Utilise ldns comme serveur DNS.
Configuration des Routeurs, Serveurs DNS et PC
Images Utilisées
    • Routeurs: Quagga
    • Serveurs DNS: Bind
Configurations de base
Chaque équipement réseau a un fichier de configuration nommé nom_de_l'équipement.startup contenant les interfaces et les adresses IP respectives.
Protocole de Routage
    • BGP: Utilisé pour le routage dynamique entre les AS.
    • RIP: Utilisé pour le routage à l'intérieur de chaque AS.
Configurations DNS
Pour le PC, son serveur DNS est Idns (ldns n'est pas un serveur maître, il ne détient aucun enregistrement de nom, si ce n'est celui du rootdns). Pour les serveurs DNS:
    • Rootdns est le serveur racine.
    • Itdns est le serveur maître de sa zone (IT) et dispose d'un enregistrement de Rootdns dans son fichier rootdns/etc/bind/db.root. Dans son fichier itdns/etc/bind/db.it, il dispose de son propre enregistrement et d'un enregistrement de R3dns.
    • R3dns est le serveur maître de sa zone (uniroma3.it) et dispose d'un enregistrement de Rootdns dans son fichier r3dns/etc/bind/db.root. Il dispose également de son propre enregistrement et de l'enregistrement du serveur web dans son fichier r3dns/etc/bind/db.it.uniroma3.
Configurations du Lab
    • Fichier lan.conf: Ce fichier résume la configuration de chaque équipement réseau, leur image (bind, kathara, quagga) et leur domaine de collision.
 
