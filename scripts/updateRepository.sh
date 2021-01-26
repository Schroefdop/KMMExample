NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'

REPOSITORY="YOUR REPOSITORY"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
REPO_VERSION=$(cat $DIR/../build.gradle.kts | grep -m 1 frameworkVersion | cut -d'"' -f 2)
TMPDIR=$(mktemp -d)
TMPFILE=$(mktemp)

trap _cleanup EXIT

function _cleanup() {
    rm -rf $TMPDIR
    rm $TMPFILE
}

function _checkTagVersion() {
    cd $TMPDIR

    git tag >$TMPFILE

    if grep -q $REPO_VERSION $TMPFILE; then
        echo "${RED}Tag $REPO_VERSION already exists${NOCOLOR}"
        echo "${RED}Update the tag in 'buildSrc/src/main/java/Config.kt' and run 'create_cocoapod.sh' again.${NOCOLOR}"
        exit 1
    fi
}

function main() {
    echo "-- Cloning repository --"
    git clone $REPOSITORY $TMPDIR

    _checkTagVersion

    echo "-- Copy framework and podspec --"
    cd $DIR/..
    cp -R /build/bin/universal/release/*.framework $TMPDIR
    cp *.podspec $TMPDIR

    cd $TMPDIR

    echo "-- Add files, make commit and tag --"
    git add --all
    git commit -m "Release $REPO_VERSION"
    git tag -a $REPO_VERSION -m "Release $($REPO_VERSION)"

    echo "-- Push to repository --"
    git push --atomic origin master $REPO_VERSION
}

main
