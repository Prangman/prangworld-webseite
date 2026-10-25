# prangworld.de

Statische Website für Prangworld (Prints, Bricks & More) – läuft auf einem eigenen Hetzner-Cloud-Server (Nürnberg) mit Caddy. Domain bei INWX.

- `index.html` – Startseite (Stand 25.10.2026: Gewerbe angemeldet, erste Produkte, Artikelübersicht folgt)
- `impressum.html`, `datenschutz.html`, `404.html` – Pflichtseiten und Fehlerseite
- `assets/` – Logo-SVGs, Favicons, selbst gehostete Sora-Schrift, Stylesheet, Produktfotos
- `deploy.sh` – Veröffentlichen auf den Server (`./deploy.sh`), Zurückrollen (`./deploy.sh rollback`). Nur nach OK von Sebastian.
- `docs-intern/` – interne Notizen, nicht im Repository (Newsletter-Vorbereitung, Hetzner-Einrichtung)

Das Repository dient als Versionsverwaltung; GitHub Pages ist seit dem 25.10.2026 abgeschaltet.

Keine Build-Schritte, keine externen Skripte, keine Cookies.
