#!/usr/bin/env bash

source $(dirname "$0")/functions.sh

if [ $# -gt 0 ]; then
  if [ "$1" == "-f" ] || [ "$1" == "--force" ]; then
    echo -e "${yellow}"
    wp db drop --path="$__WPPath__"
    echo -e "${reset}"
  fi
fi

wp db create --path="$__WPPath__"

#ask for parameter
read -p "${yellow}Please Type ${bold}Site URL${yellow} i.e.: http://localhost: ${green}" SiteURL
read -p "${yellow}Please Type ${bold}Site title${yellow}: ${green}" SiteTitle
read -p "${yellow}Please Type Default ${bold}Admin User Email${yellow}: ${green}" SiteAdminEmail
read -p "${yellow}Please Type Default ${bold}Admin User${yellow}: ${green}" SiteAdmin
read -sp "${yellow}Please Type Default ${bold}Admin User Password${yellow}: ${green}" SiteAdminPassword
echo "${reset}"

wp core install --path="$__WPPath__" --url="${SiteURL}" --title="${SiteTitle}" --admin_user="${SiteAdmin}" --admin_password="${SiteAdminPassword}" --admin_email="${SiteAdminEmail}"

wp option update siteurl $(wp option get siteurl --path="$__WPPath__")/wp --path="$__WPPath__"
