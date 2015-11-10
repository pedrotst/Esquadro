echo "Creating source info database..."

POSTGRES_USER="postgres"

createdb -O $POSTGRES_USER source_info

echo "Creating success"
