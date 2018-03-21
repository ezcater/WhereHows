#!/bin/bash
set -e

VERSION=$1
if [ -z "$VERSION" ]; then
  echo "Usage: $0 <version>"
  exit 0
fi

# Assumption: docker is already installed
# Also, you should be in the sudoers

# Build the application's distribution zip
(cd .. && ./gradlew dist)

# Build docker images
(cd wherehows-frontend && ./build.sh $VERSION)
(cd wherehows-backend && ./build.sh $VERSION)
(cd wherehows-mysql && ./build.sh $VERSION)
(cd wherehows-postgres && ./build.sh $VERSION)
(cd wherehows-elasticsearch && ./build.sh $VERSION)

cd ..
echo "now run one of these to start the application:"
echo "docker-compose -f docker-compose-mysql.yml up # To use a MySQL DB"
echo "docker-compose -f docker-compose-postgres.yml up # To use a Postgres DB"
