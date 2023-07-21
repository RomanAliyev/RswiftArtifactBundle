set -ex

VERSION="7.3.2"
RELEASE_URL="https://github.com/mac-cain13/R.swift/releases/download/7.3.2/rswift-7.3.2.zip"

curl -L $RELEASE_URL -o release.zip
unzip release.zip -d release

mkdir -p rswift.artifactbundle/rswift/bin
cp release/rswift rswift.artifactbundle/rswift/bin
cp release/License rswift.artifactbundle/rswift

cat <<EOF > rswift.artifactbundle/info.json
{
    "schemaVersion": "1.0",
    "artifacts": {
        "rswift": {
            "type": "executable",
            "version": "$VERSION",
            "variants": [
                {
                    "path": "rswift/bin/rswift",
                    "supportedTriples": ["x86_64-apple-macosx", "arm64-apple-macosx"]
                },
            ]
        }
    }
}
EOF

zip -r rswift-$VERSION.artifactbundle.zip rswift.artifactbundle

swift package compute-checksum rswift-$VERSION.artifactbundle.zip > checksum.txt
