set -eux
TIMESTAMP=$(date "+%Y%m%d-%H%M%S")

TARGET="sweetmusic-vol7"

curl -X POST -f -H "Authorization: Bearer ${DROPBOX_TOKEN}" \
	-D - -H "Dropbox-API-Arg: {\"path\": \"/${TARGET}-${TIMESTAMP}.pdf\",\"mode\": \"overwrite\",\"mute\": false}" -H "Content-Type: application/octet-stream" --data-binary @target/${TARGET}.pdf https://content.dropboxapi.com/2/files/upload
