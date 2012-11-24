#!/bin/sh

if [ $# -lt 1 ]; then
    echo "Please supply a tag number"
    exit 1;
fi
VERSION="$1";
GZIPPED_REPO="Services_Twilio-$VERSION.tgz"

pushd ../twilio-php;
    pear install XML_Serializer-0.20.2 PEAR_PackageFileManager_Plugins PEAR_PackageFileManager2
    pear channel-discover twilio.github.com/pear
    php package.php > package.xml;
    pear package;
    cp $GZIPPED_REPO ../pear;
popd;

pirum add . $GZIPPED_REPO;
rm -f $GZIPPED_REPO;

git add .;
git ci -m "Bump PEAR library version to $VERSION"

echo 'New version added to the repository. Push to Github to update PEAR'
