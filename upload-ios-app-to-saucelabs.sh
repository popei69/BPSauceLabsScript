#!/bin/sh
# author : Benoit Pasquier
# website : http://benoitpasquier.fr
# github : https://github.com/popei69/BPSauceLabsScript

readonly archive_file_name=myApp.zip

# gettings extra params
tmpPath=$1
username=$2
accessKey=$3

# moving to a temporary directory
tmp_dir="$(mktemp -d -t tmp_dir_app.XXXXXXXXX)"

if [ $? -ne 0 ] || [ -z "$tmp_dir" ]
then
	echo 'A temporary directory could not be created.'
  exit 1
fi

readonly tmp_dir
(
	cd "$tmp_dir"

	echo
	echo '[info]' "Zipping up into $archive_file_name"
	zip -r "$archive_file_name" "$tmpPath" > /dev/null

	echo
	echo '[info]' 'List files created'
	ls -l

	echo
	echo '[info]' 'Display current md5 hash.'
	md5 "$archive_file_name"

	echo
	echo '[info]' 'Posting the zip archive to Saucelabs.'
	curl -u "$username":"$accessKey" \
		 -X POST \
		 -H 'Content-Type: application/octet-stream' \
		 --data-binary @myApp.zip \
		 "https://saucelabs.com/rest/v1/storage/$username/$archive_file_name?overwrite=true"

	echo
	echo '[info]' 'List zip files from Saucelabs.'

	curl -u "$username":"$accessKey" \
		 "https://saucelabs.com/rest/v1/storage/$username"
)

rm -r "$tmp_dir"

echo '[info]' "Finished."
