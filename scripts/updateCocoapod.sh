REPO_VERSION=$(cat ../buildSrc/src/main/java/Config.kt | grep version | cut -d'"' -f 2)

sed -i '' -e "s?spec\.version = .*?""spec\.version = \'$REPO_VERSION\'?" ../ExampleProject.podspec
