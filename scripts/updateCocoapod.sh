DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
REPO_VERSION=$(cat $DIR/../build.gradle.kts | grep -m 1 frameworkVersion | cut -d'"' -f 2)
sed -i '' -e "s?spec\.version = .*?""spec\.version = \'$REPO_VERSION\'?" $DIR/../ExampleProject.podspec
