# Webs Mother's Day por país — Setup y uso

Este documento explica cómo crear y mantener los sitios estáticos de Mother's Day para cada país (ES, FR, DE, IT, MX, BR, CA, AU) a partir del template UK.

## 1. Crear los proyectos por país

Desde la raíz del repo **Mothers Day Seasonality** (template UK):

```bash
node scripts/create-country-sites.js --base="C:\Users\FEVER\Documents\MOTHERS DAY"
```

- Crea (o actualiza) las carpetas `ES`, `FR`, `DE`, `IT`, `MX`, `BR`, `CA`, `AU` bajo la ruta indicada.
- En cada carpeta: copia el template (excluyendo `.git`, `node_modules`, `.cursor` y carpetas de ciudades UK).
- Escribe `data/campaigns/mothers-day-<country>.json` con dominio, GA4, locale, copy y ciudades de ejemplo.
- Sustituye en ese proyecto el GA ID y el dominio en `js/main.js`, `js/main.min.js`, `legal/cookies.html`, `index.html` y `404.html`.

Para crear solo algunos países:

```bash
node scripts/create-country-sites.js --base="C:\Users\FEVER\Documents\MOTHERS DAY" --countries=IT,MX,BR
```

## 2. Completar ciudades y generar páginas

Cada país tiene por defecto 2 ciudades de ejemplo en su config. Para añadir o cambiar ciudades:

1. Edita en el proyecto del país el archivo `data/campaigns/mothers-day-<country>.json`.
2. Modifica el array `cities` con `{ "slug": "ciudad", "name": "Nombre" }` (el `slug` se usa en las URLs de Fever y en las rutas del sitio).
3. Desde la carpeta de ese país, ejecuta:

```bash
npm install
node scripts/generate-city-pages.js --campaign=mothers-day-<country>
```

Por ejemplo, para España:

```bash
cd "C:\Users\FEVER\Documents\MOTHERS DAY\ES"
node scripts/generate-city-pages.js --campaign=mothers-day-es
```

Si usas datos de Fever, antes puedes ejecutar el fetch de planes (si existe script configurado para esa campaña).

## 3. Abrir Cursor por país

Para abrir una ventana de Cursor por cada país:

```powershell
.\scripts\open-cursor-workspaces.ps1
```

Por defecto usa la ruta `C:\Users\FEVER\Documents\MOTHERS DAY`. Para otra ruta:

```powershell
.\scripts\open-cursor-workspaces.ps1 -Base "D:\MOTHERS DAY"
```

Requisito: el comando `cursor` debe estar en el PATH (habitual si Cursor está instalado).

## 4. Build y deploy por país

Cada carpeta (ES, FR, DE, …) es un sitio estático independiente.

- **Build:** desde la carpeta del país, `npm run build` (o el equivalente del template) para regenerar CSS/JS minificados y, si aplica, páginas de ciudad.
- **Deploy:** usar el mismo `cloudbuild.yaml` (o una copia por país) con el proyecto/servicio correspondiente en Google Cloud; los IDs de proyecto (523124582, 523090730, etc.) se configuran en el trigger de Cloud Build de cada país, y el dominio se mapea al sitio (celebrardiadelamadre.es, celebrerfetedesmeres.fr, etc.).

La redirección .com.mx → .mx para México se configura a nivel DNS/servidor, no en el código.

## 5. Countdown por país

Por defecto los configs tienen `countdownType: "none"`. Para activar la cuenta atrás por país habría que extender el template con las fechas de Mother's Day por locale (por ejemplo segundo domingo de mayo para la mayoría; excepciones para UK, ES, FR, MX). Ver `docs/COMO-CREAR-OTRO-SITE.md` para el esquema de countdown.
