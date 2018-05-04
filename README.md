# Development Environment - Drupal

- DITS: 0.0.4

## Helper Scripts

Simple bash scripts that automate little tasks, these are available in
`/home/app/.local/bin`

- `d-dump`: Backup default database, requires `drush`.
- `d-export`: Export files and database, requires `drush`.
- `d-password-reset`: Reset Admin password to 'password', requires `drush`.
- `d-permissions`: Create writeable permissions for various files, eg:
  `settings.php`, requires `drush`.
- `d7-dev`: Set site mode to 'development', requires `drush`.
- `d7-fs`: Set file locations to current site, requires `drush` (Drupal 7).
- `d7-stage-file-proxy`: Enable add configure stage file proxy module, requires
  `drush` (Drupal 7).
- `d8-dev`: Set site mode to 'development', requires `drush` and `drupal-console`
  (Drupal 8).
- `d8-fs`: Set file locations to current site, requires `drush` (Drupal 8).
- `d8-stage-file-proxy`: Enable add configure stage file proxy module, requires
  `drush` (Drupal 8).
