#!/usr/bin/env bash

# Check for Drupal installation;
function drupal-install () {
  drush drupal-directory > /dev/null;
}
